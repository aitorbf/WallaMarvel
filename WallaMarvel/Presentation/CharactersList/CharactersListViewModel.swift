//
//  CharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//
// swiftlint:disable no_magic_numbers

import Foundation
import SwiftUI

protocol CharactersListViewModel: ObservableObject {
    var characters: [Character] { get set }
    var isLoading: Bool { get set }
    
    func getCharacters() async
    func loadMoreCharacters(currentIndex: Int) async
}
    
final class CharactersListViewModelImpl: CharactersListViewModel {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    
    private let getCharactersUseCase: GetCharactersUseCase
    private let limit: Int = 50
    
    private var offset: Int = 0
    private var isFetching = false
    private var canFetchMore = true
    
    init(getCharactersUseCase: GetCharactersUseCase) {
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    @MainActor
    func getCharacters() async {
        guard !isFetching, canFetchMore else {
            return
        }
        
        isFetching = true
        
        do {
            let charactersPage = try await getCharactersUseCase.execute(
                offset: offset,
                limit: limit
            )
            print("Characters \(charactersPage.characters)")
            characters.append(contentsOf: charactersPage.characters)
            offset += charactersPage.count
            canFetchMore = characters.count < charactersPage.total
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
        }
        
        isLoading = false
        isFetching = false
    }
    
    func loadMoreCharacters(currentIndex: Int) async {
        guard !isFetching, canFetchMore else {
            return
        }
        
        let thresholdIndex = characters.count - (limit / 2)
        if currentIndex >= thresholdIndex {
            await getCharacters()
        }
    }
}

// swiftlint:enable no_magic_numbers
