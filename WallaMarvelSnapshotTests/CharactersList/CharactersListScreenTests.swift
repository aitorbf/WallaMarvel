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
        let charactersListScreen = CharactersListView(viewModel: MockCharactersListViewModel())
        let viewController = UIHostingController(rootView: charactersListScreen)
        
        CharactersListUIGroup.screenshots(viewController, name: "LoadingCharactersListScreen")
    }
    
    func testContentCharactersListScreen() throws {
        let viewModel =  MockCharactersListViewModel()
        viewModel.characters = Character.mockList()
        viewModel.isLoading = false
        let charactersListScreen = CharactersListView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: charactersListScreen)
        
        CharactersListUIGroup.screenshots(viewController, name: "ContentCharactersListScreen")
    }
}
