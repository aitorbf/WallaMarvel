//
//  CharacterDetailViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//

import Foundation

protocol CharacterDetailViewModel: ObservableObject {
    var character: Character { get }
}

final class CharacterDetailViewModelImpl: CharacterDetailViewModel {
    
    var character: Character
    
    init(character: Character) {
        self.character = character
    }
}
