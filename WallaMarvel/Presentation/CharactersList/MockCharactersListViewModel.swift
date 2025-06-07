//
//  MockCharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//
// swiftlint:disable no_magic_numbers

import Foundation
import SwiftUI

final class MockCharactersListViewModel: CharactersListViewModel {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    
    private let limit: Int = 20
    private let total: Int = 100
    
    private var offset: Int = 0
    private var canFetchMore = true
    
    @MainActor
    func getCharacters() async {
        let charactersPage = CharactersPage.mock(
            offset: offset,
            total: total,
            characters: Character.mockList(
                offset: offset,
                count: limit
            )
        )
        characters.append(contentsOf: charactersPage.characters)
        offset += charactersPage.count
        canFetchMore = characters.count < charactersPage.total
        isLoading = false
    }
    
    func loadMoreCharacters(currentIndex: Int) async {
        let thresholdIndex = characters.count - (limit / 2)
        if currentIndex >= thresholdIndex && canFetchMore {
            await getCharacters()
        }
    }
}

// swiftlint:enable no_magic_numbers
