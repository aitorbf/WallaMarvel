//
//  CharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation
import SwiftUI

protocol CharactersListViewModel: ObservableObject {
    var characters: [Character] { get set }
    var isLoading: Bool { get set }
    
    func getCharacters() async
}
    
final class CharactersListViewModelImpl: CharactersListViewModel {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    
    private let getCharactersUseCase: GetCharactersUseCase
    
    init(getCharactersUseCase: GetCharactersUseCase) {
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    @MainActor
    func getCharacters() async {
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
