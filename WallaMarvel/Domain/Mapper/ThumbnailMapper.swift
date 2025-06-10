//
//  ThumbnailMapper.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct ThumbnailMapper {
    
    static func map(_ entity: ThumbnailEntity?) -> Thumbnail {
        guard let path = entity?.path, let ext = entity?.extension else {
            return Thumbnail(standard: "", portrait: "", landscape: "")
        }
        
        return Thumbnail(
            standard: "\(path)/standard_medium.\(ext)",
            portrait: "\(path)/portrait_xlarge.\(ext)",
            landscape: "\(path)/landscape_xlarge.\(ext)"
        )
    }
}
