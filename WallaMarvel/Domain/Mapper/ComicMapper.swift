//
//  ComicMapper.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct ComicMapper {
    
    static func map(_ entity: ComicEntity) -> Comic {
        .init(
            id: entity.id,
            title: entity.title ?? "",
            description: entity.description ?? "",
            pages: entity.pageCount ?? 0,
            thumbnail: ThumbnailMapper.map(entity.thumbnail)
        )
    }
}
