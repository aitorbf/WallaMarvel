//
//  MockCharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import Foundation
import SwiftUI
import Combine

final class MockCharactersListViewModel: CharactersListViewModel {
    
    @Published var viewState: CharactersListViewState = .loading
    @Published var characters: [Character] = []
    @Published var searchText: String = ""
    
    init(characters: [Character] = Character.mockList()) {
        self.characters = characters
        if !characters.isEmpty {
            viewState = .loaded
        }
    }
    
    @MainActor
    func getCharacters() async {
        // Intentionally empty
    }
    
    func loadMoreCharacters(currentIndex: Int) async {
        // Intentionally empty
    }
}
