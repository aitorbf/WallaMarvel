//
//  CharacterDetailScreenTests.swift
//  WallaMarvelSnapshotTests
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import WallaMarvel

final class CharacterDetailScreenTests: XCTestCase {
    
    func testCharacterDetailScreen() throws {
        let viewModel =  MockCharacterDetailViewModel()
        let characterDetailScreen = CharacterDetailView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: characterDetailScreen)
        
        CharacterDetailUIGroup.screenshots(viewController, name: "CharacterDetailScreen")
    }
    
    func testCharacterDetailWithoutDescriptionScreen() throws {
        let viewModel =  MockCharacterDetailViewModel(
            character: .mock(
                id: 1,
                name: "Character 1",
                description: ""
            )
        )
        let characterDetailScreen = CharacterDetailView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: characterDetailScreen)
        
        CharacterDetailUIGroup.screenshots(viewController, name: "CharacterDetailWithoutDescriptionScreen")
    }
    
    func testCharacterDetailWithoutComicsScreen() throws {
        let viewModel =  MockCharacterDetailViewModel(comics: [])
        let characterDetailScreen = CharacterDetailView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: characterDetailScreen)
        
        CharacterDetailUIGroup.screenshots(viewController, name: "CharacterDetailWithoutComicsScreen")
    }
    
    func testCharacterDetailWithComicSelectedScreen() throws {
        let comics = Comic.mockList()
        let viewModel =  MockCharacterDetailViewModel(comics: comics, selectedComic: comics.first)
        let characterDetailScreen = CharacterDetailView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: characterDetailScreen)
        
        CharacterDetailUIGroup.screenshots(viewController, name: "CharacterDetailWithComicSelectedScreen")
    }
}
