//
//  GetCharacterComicsUseCase.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

// sourcery: AutoMockable
protocol GetCharacterComicsUseCase {
    func execute(
        characterId: Int,
        offset: Int,
        limit: Int
    ) async throws -> ComicsPage
}

struct GetCharacterComicsUseCaseImpl: GetCharacterComicsUseCase {
    
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func execute(
        characterId: Int,
        offset: Int,
        limit: Int
    ) async throws -> ComicsPage {
        let comicDataContainer = try await repository.getCharacterComics(
            characterId: characterId,
            offset: offset,
            limit: limit
        )
        return ComicsPageMapper.map(comicDataContainer)
    }
}
