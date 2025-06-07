//
//  MockCharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import Foundation
import SwiftUI

final class MockCharactersListViewModel: CharactersListViewModel {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    
    init() {
        Task { @MainActor in
            await getCharacters()
        }
    }
    
    @MainActor
    func getCharacters() async {
        characters = CharactersPage.mock().characters
        isLoading = false
    }
}
