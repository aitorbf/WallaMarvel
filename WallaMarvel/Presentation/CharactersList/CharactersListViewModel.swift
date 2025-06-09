//
//  CharactersListViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation
import SwiftUI
import Combine

protocol CharactersListViewModel: ObservableObject {
    var characters: [Character] { get set }
    var isLoading: Bool { get set }
    var searchText: String { get set }
    
    func getCharacters() async
    func loadMoreCharacters(currentIndex: Int) async
}
    
final class CharactersListViewModelImpl: CharactersListViewModel {
    
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = true
    @Published var searchText: String = ""
    
    private let getCharactersUseCase: GetCharactersUseCase
    private let limit: Int = 50
    private let searchDebounceMilliseconds: Int = 500
    
    private var offset: Int = 0
    private var isFetching = false
    private var canFetchMore = true
    private var cancellables = Set<AnyCancellable>()
    
    init(getCharactersUseCase: GetCharactersUseCase) {
        self.getCharactersUseCase = getCharactersUseCase
        observeSearchChanges()
    }
    
    @MainActor
    func getCharacters() async {
        guard !isFetching, canFetchMore else {
            return
        }
        
        isLoading = characters.isEmpty
        isFetching = true
        
        do {
            let charactersPage = try await getCharactersUseCase.execute(
                offset: offset,
                limit: limit,
                searchText: searchText
            )
            print("Characters \(charactersPage.characters)")
            
            offset += charactersPage.count
            characters.append(contentsOf: charactersPage.characters)
            canFetchMore = characters.count < charactersPage.total
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
        }
        
        isLoading = false
        isFetching = false
    }
    
    // swiftlint:disable no_magic_numbers
    func loadMoreCharacters(currentIndex: Int) async {
        guard !isFetching, canFetchMore else {
            return
        }
        
        let thresholdIndex = characters.count - (limit / 2)
        if currentIndex >= thresholdIndex {
            await getCharacters()
        }
    }
    // swiftlint:enable no_magic_numbers
}

private extension CharactersListViewModelImpl {
    
    private func observeSearchChanges() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(searchDebounceMilliseconds), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                Task { @MainActor in
                    self.resetState()
                    await self.getCharacters()
                }
            }
            .store(in: &cancellables)
    }
    
    private func resetState() {
        characters = []
        offset = 0
        isFetching = false
        canFetchMore = true
    }
}
