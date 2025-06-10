//
//  CharactersListScreenTests.swift
//  WallaMarvelUITests
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import WallaMarvel

final class CharactersListScreenTests: XCTestCase {
    
    func testLoadingCharactersListScreen() throws {
        let viewModel = MockCharactersListViewModel(characters: [])
        let charactersListScreen = CharactersListView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: charactersListScreen)
        
        CharactersListUIGroup.screenshots(viewController, name: "LoadingCharactersListScreen")
    }
    
    func testContentCharactersListScreen() throws {
        let viewModel =  MockCharactersListViewModel()
        let charactersListScreen = CharactersListView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: charactersListScreen)
        
        CharactersListUIGroup.screenshots(viewController, name: "ContentCharactersListScreen")
    }
}
