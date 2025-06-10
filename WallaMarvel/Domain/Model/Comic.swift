//
//  Comic.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct Comic {
    
    let id: Int
    let title: String
    let description: String
    let pages: Int
    let thumbnail: Thumbnail
}

extension Comic {
    
    static func mock(
        id: Int = 1,
        title: String = "Comic 1",
        description: String = "Description for comic 1",
        pages: Int = 100,
        thumbnail: Thumbnail = .mock(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/40/64d117c31c0a1")
    ) -> Comic {
        Comic(
            id: id,
            title: title,
            description: description,
            pages: pages,
            thumbnail: thumbnail
        )
    }
    
    static func mockList(offset: Int = 0, count: Int = 10) -> [Comic] {
        (1...count).map { i in
            .mock(
                id: i + offset,
                title: "Comic \(i + offset)",
                description: "Description for comic \(i + offset)"
            )
        }
    }
}
