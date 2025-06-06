//
//  Character.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

struct Character {
    
    let id: Int
    let name: String
    let thumbnail: String
}

extension Character {
    
    static func mock(
        id: Int = 1,
        name: String = "Character 1",
        thumbnail: String = "https://picsum.photos/seed/character/100"
    ) -> Character {
        Character(
            id: id,
            name: name,
            thumbnail: thumbnail
        )
    }

    static func mockList(count: Int = 10) -> [Character] {
        (1...count).map { i in
            .mock(
                id: i,
                name: "Character \(i)"
            )
        }
    }
}
