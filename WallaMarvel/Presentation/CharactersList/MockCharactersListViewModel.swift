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
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    
    private let limit: Int = 20
    private let total: Int = 100
    private let searchDebounceMilliseconds: Int = 500
    
    private var offset: Int = 0
    private var canFetchMore = true
    private var allCharacters: [Character] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        observeSearchChanges()
    }
    
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
        
        offset += charactersPage.count
        allCharacters.append(contentsOf: charactersPage.characters)
        characters = filterCharacters(allCharacters)
        canFetchMore = allCharacters.count < total
        isLoading = false
    }
    
    // swiftlint:disable no_magic_numbers
    func loadMoreCharacters(currentIndex: Int) async {
        let thresholdIndex = characters.count - (limit / 2)
        if currentIndex >= thresholdIndex && canFetchMore {
            await getCharacters()
        }
    }
    // swiftlint:enable no_magic_numbers
}

private extension MockCharactersListViewModel {
    
    private func observeSearchChanges() {
        $searchText
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .milliseconds(searchDebounceMilliseconds), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                self.characters = self.filterCharacters(self.allCharacters)
            }
            .store(in: &cancellables)
    }
    
    private func filterCharacters(_ characters: [Character]) -> [Character] {
        if searchText.isEmpty {
            return allCharacters
        } else {
            return characters.filter { character in
                character.name.lowercased().hasPrefix(searchText.lowercased())
            }
        }
    }
}
