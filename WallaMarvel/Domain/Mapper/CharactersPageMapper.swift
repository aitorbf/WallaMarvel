//
//  CharactersPageMapper.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

struct CharactersPageMapper {
    
    static func map(_ entity: CharacterDataContainerEntity) -> CharactersPage {
        .init(
            offset: entity.offset ?? 0,
            count: entity.count ?? 0,
            total: entity.total ?? 0,
            characters: (entity.characters ?? []).map { CharacterMapper.map($0) }
        )
    }
}
