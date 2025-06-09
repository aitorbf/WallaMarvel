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
            thumbnail: mapThumbnail(
                path: entity.thumbnail?.path,
                extension: entity.thumbnail?.extension
            )
        )
    }
}

private extension CharacterMapper {
    
    static func mapThumbnail(path: String?, extension: String?) -> Thumbnail {
        guard let path = path, let ext = `extension` else {
            return Thumbnail(standard: "", portrait: "", landscape: "")
        }
        
        return Thumbnail(
            standard: "\(path)/standard_medium.\(ext)",
            portrait: "\(path)/portrait_xlarge.\(ext)",
            landscape: "\(path)/landscape_xlarge.\(ext)"
        )
    }
}
