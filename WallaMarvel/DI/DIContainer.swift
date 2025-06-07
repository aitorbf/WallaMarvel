//
//  DIContainer.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 6/6/25.
//
//  Dependency injection container powered by Swinject.
//  ----------------------------------------------------
//
//  Summary:
//  - Centralized container to resolve dependencies
//  - Registered data sources, repositories, use cases and view models
//  - Uses inObjectScope(.container) for shared dependencies
//  - Only exposes ViewModels publicly
//
//  Usage:
//  - Access via DIContainer.shared
//  - Example:
//      let viewModel = DIContainer.shared.charactersListViewModel()
//

import Foundation
import Swinject

final class DIContainer {
    
    static let shared = DIContainer()
    
    private let container: Container

    private init() {
        container = Container()
        
        registerDataSources()
        registerRepositories()
        registerUseCases()
        registerViewModels()
    }
    
    func charactersListViewModel() -> CharactersListViewModelImpl {
        guard let viewModel = container.resolve(CharactersListViewModelImpl.self) else {
            fatalError("CharactersListViewModel dependency could not be resolved.")
        }
        return viewModel
    }
}

private extension DIContainer {
    
    func registerDataSources() {
        container.register(CharactersRemoteDataSource.self) { _ in
            CharactersRemoteDataSourceImpl()
        }
        .inObjectScope(.container)
    }
    
    func registerRepositories() {
        container.register(CharactersRepository.self) { resolver in
            guard let remoteDataSource = resolver.resolve(CharactersRemoteDataSource.self) else {
                fatalError("CharactersRemoteDataSource dependency could not be resolved.")
            }
            return CharactersRepositoryImpl(remoteDataSource: remoteDataSource)
        }
        .inObjectScope(.container)
    }
    
    func registerUseCases() {
        container.register(GetCharactersUseCase.self) { resolver in
            guard let repository = resolver.resolve(CharactersRepository.self) else {
                fatalError("CharactersRepository dependency could not be resolved.")
            }
            return GetCharactersUseCaseImpl(repository: repository)
        }
        .inObjectScope(.container)
    }
    
    func registerViewModels() {
        container.register(CharactersListViewModelImpl.self) { resolver in
            guard let useCase = resolver.resolve(GetCharactersUseCase.self) else {
                fatalError("GetCharactersUseCase dependency could not be resolved.")
            }
            return CharactersListViewModelImpl(getCharactersUseCase: useCase)
        }
    }
}
