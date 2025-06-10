//
//  ComicDataContainerEntity.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct ComicDataContainerEntity: Decodable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let comics: [ComicEntity]?
}

extension ComicDataContainerEntity {
    
    enum CodingKeys: String, CodingKey {
        case data
        case offset, limit, total, count, comics = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.offset = try data.decode(Int.self, forKey: .offset)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.total = try data.decode(Int.self, forKey: .total)
        self.count = try data.decode(Int.self, forKey: .count)
        self.comics = try data.decode([ComicEntity].self, forKey: .comics)
    }
}

// swiftlint:disable no_magic_numbers
extension ComicDataContainerEntity {
    
    static func mock(
        offset: Int = 0,
        limit: Int = 20,
        total: Int = 20,
        comics: [ComicEntity] = ComicEntity.mockList(count: 20)
    ) -> ComicDataContainerEntity {
        ComicDataContainerEntity(
            offset: offset,
            limit: limit,
            total: total,
            count: comics.count,
            comics: comics
        )
    }
}
// swiftlint:enable no_magic_numbers
