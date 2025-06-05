//
//  CharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation
import SwiftUI

final class CharactersListViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    
    private let getCharactersUseCase: GetCharactersUseCase
    
    init(getCharactersUseCase: GetCharactersUseCase = GetCharactersUseCaseImpl()) {
        self.getCharactersUseCase = getCharactersUseCase
        Task { @MainActor in
            await getCharacters()
        }
    }
    
    @MainActor
    func getCharacters() async {
        isLoading = true
        
        do {
            let charactersPage = try await getCharactersUseCase.execute()
            print("Characters \(charactersPage.characters)")
            characters = charactersPage.characters
            isLoading = false
        } catch {
            isLoading = false
            print("Error fetching characters: \(error.localizedDescription)")
        }
    }
}
