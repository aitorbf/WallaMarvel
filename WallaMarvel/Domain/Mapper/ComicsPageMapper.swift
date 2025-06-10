//
//  ComicsPageMapper.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct ComicsPageMapper {
    
    static func map(_ entity: ComicDataContainerEntity) -> ComicsPage {
        .init(
            offset: entity.offset ?? 0,
            count: entity.count ?? 0,
            total: entity.total ?? 0,
            comics: (entity.comics ?? []).map { ComicMapper.map($0) }
        )
    }
}
