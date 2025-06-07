//
//  CharactersPage.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

struct CharactersPage {
    
    let offset: Int
    let count: Int
    let total: Int
    let characters: [Character]
}

// swiftlint:disable no_magic_numbers
extension CharactersPage {
    
    static func mock(
        offset: Int = 0,
        total: Int = 20,
        characters: [Character] = Character.mockList(count: 20)
    ) -> CharactersPage {
        CharactersPage(
            offset: offset,
            count: characters.count,
            total: total,
            characters: characters
        )
    }
}
// swiftlint:enable no_magic_numbers
