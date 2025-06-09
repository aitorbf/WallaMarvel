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
    let description: String
    let thumbnail: Thumbnail
}

extension Character {
    
    static func mock(
        id: Int = 1,
        name: String = "Character 1",
        description: String = "Description for character 1",
        thumbnail: Thumbnail = .mock()
    ) -> Character {
        Character(
            id: id,
            name: name,
            description: description,
            thumbnail: thumbnail
        )
    }

    static func mockList(offset: Int = 0, count: Int = 10) -> [Character] {
        (1...count).map { i in
            .mock(
                id: i + offset,
                name: "Character \(i + offset)",
                description: "Description for character \(i + offset)"
            )
        }
    }
}
