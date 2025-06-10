//
//  ComicEntity.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct ComicEntity: Codable {
    
    let id: Int
    let title: String?
    let description: String?
    let pageCount: Int?
    let thumbnail: ThumbnailEntity?
}

extension ComicEntity {
    
    static func mock(
        id: Int = 1,
        title: String? = "Comic 1",
        description: String? = "Description for comic 1",
        pageCount: Int? = 100,
        thumbnailPath: String? = "https://marvel.com/comic/1/image",
        thumbnailExt: String? = "jpg"
    ) -> ComicEntity {
        ComicEntity(
            id: id,
            title: title,
            description: description,
            pageCount: pageCount,
            thumbnail: ThumbnailEntity(path: thumbnailPath, extension: thumbnailExt)
        )
    }
    
    static func mockList(count: Int = 10) -> [ComicEntity] {
        (1...count).map { i in
            .mock(
                id: i,
                title: "Comic \(i)",
                description: "Description for comic \(i)",
                thumbnailPath: "https://marvel.com/comic/\(i)/image"
            )
        }
    }
}
