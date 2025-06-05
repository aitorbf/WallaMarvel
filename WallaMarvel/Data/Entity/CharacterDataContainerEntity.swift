import Foundation

struct CharacterDataContainerEntity: Decodable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let characters: [CharacterEntity]?
}

extension CharacterDataContainerEntity {
    
    enum CodingKeys: String, CodingKey {
        case data
        case offset, limit, total, count, characters = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.offset = try data.decode(Int.self, forKey: .offset)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.total = try data.decode(Int.self, forKey: .total)
        self.count = try data.decode(Int.self, forKey: .count)
        self.characters = try data.decode([CharacterEntity].self, forKey: .characters)
    }
}
