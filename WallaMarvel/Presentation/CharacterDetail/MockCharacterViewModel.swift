//
//  MockCharacterViewModel.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//

import Foundation

final class MockCharacterDetailViewModel: CharacterDetailViewModel {
    
    var character: Character
    
    init(character: Character = Character.mock()) {
        self.character = character
    }
}
