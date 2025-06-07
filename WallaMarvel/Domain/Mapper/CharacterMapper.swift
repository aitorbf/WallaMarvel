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
            thumbnail: mapThumbnail(
                path: entity.thumbnail?.path,
                extension: entity.thumbnail?.extension
            )
        )
    }
}

private extension CharacterMapper {
    
    static func mapThumbnail(path: String?, extension: String?) -> String {
        guard let path = path, let ext = `extension` else {
            return ""
        }
        
        return "\(path)/standard_medium.\(ext)"
    }
}
