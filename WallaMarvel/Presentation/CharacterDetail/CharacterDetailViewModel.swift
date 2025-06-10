//
//  CharacterDetailViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//

import Foundation

protocol CharacterDetailViewModel: ObservableObject {
    var character: Character { get }
    var comics: [Comic] { get set }
    var isLoadingComics: Bool { get set }
    var selectedComic: Comic? { get }
    
    func getComics() async
    func loadMoreComics(currentIndex: Int) async
    func selectComic(_ comic: Comic)
}

final class CharacterDetailViewModelImpl: CharacterDetailViewModel {
    
    var character: Character
    @Published var comics: [Comic] = []
    @Published var isLoadingComics: Bool = true
    @Published var selectedComic: Comic?
    
    private let getCharacterComicsUseCase: GetCharacterComicsUseCase
    private let comicsLimit: Int = 20
    
    private var comicsOffset: Int = 0
    private var isFetchingComics = false
    private var canFetchMoreComics = true
    
    init(
        character: Character,
        getCharacterComicsUseCase: GetCharacterComicsUseCase
    ) {
        self.character = character
        self.getCharacterComicsUseCase = getCharacterComicsUseCase
    }
    
    @MainActor
    func getComics() async {
        guard !isFetchingComics, canFetchMoreComics else {
            return
        }
        
        isLoadingComics = comics.isEmpty
        isFetchingComics = true
        
        do {
            let comicsPage = try await getCharacterComicsUseCase.execute(
                characterId: character.id,
                offset: comicsOffset,
                limit: comicsLimit
            )
            
            comicsOffset += comicsPage.count
            comics.append(contentsOf: comicsPage.comics)
            canFetchMoreComics = comics.count < comicsPage.total
        } catch {
            print("Error fetching comics: \(error.localizedDescription)")
        }
        
        isLoadingComics = false
        isFetchingComics = false
    }
    
    // swiftlint:disable no_magic_numbers
    func loadMoreComics(currentIndex: Int) async {
        guard !isFetchingComics, canFetchMoreComics else {
            return
        }
        
        let thresholdIndex = comics.count - (comicsLimit / 2)
        if currentIndex >= thresholdIndex {
            await getComics()
        }
    }
    // swiftlint:enable no_magic_numbers
    
    func selectComic(_ comic: Comic) {
        selectedComic = comic.id == selectedComic?.id ? nil : comic
    }
}
