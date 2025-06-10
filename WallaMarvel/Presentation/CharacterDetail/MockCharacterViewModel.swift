//
//  MockCharacterViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//

import Foundation

final class MockCharacterDetailViewModel: CharacterDetailViewModel {
    
    var character: Character
    @Published var comics: [Comic] = []
    @Published var isLoadingComics: Bool = true
    @Published var selectedComic: Comic?
    
    init(
        character: Character = Character.mock(),
        comics: [Comic] = Comic.mockList(),
        selectedComic: Comic? = nil
    ) {
        self.character = character
        self.comics = comics
        self.selectedComic = selectedComic
        if !comics.isEmpty {
            self.isLoadingComics = false
        }
    }
    
    func getComics() async {
        // Intentionally empty
    }
    
    func loadMoreComics(currentIndex: Int) async {
        // Intentionally empty
    }
    
    func selectComic(_ comic: Comic) {
        // Intentionally empty
    }
}
