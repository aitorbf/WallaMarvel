//
//  CharacterMapper.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

struct CharacterMapper {
    
    static func map(_ entity: CharacterEntity) -> Character {
        .init(
            id: entity.id,
            name: entity.name ?? "",
            description: entity.description ?? "",
            thumbnail: ThumbnailMapper.map(entity.thumbnail)
        )
    }
}
