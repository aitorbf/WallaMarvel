import Foundation

struct CharacterEntity: Codable {
    
    let id: Int
    let name: String?
    let thumbnail: ThumbnailEntity?
}

extension CharacterEntity {
    
    static func mock(
        id: Int = 1,
        name: String = "Character 1",
        thumbnailPath: String = "https://marvel.com/character/1/image",
        thumbnailExt: String = "jpg"
    ) -> CharacterEntity {
        CharacterEntity(
            id: id,
            name: name,
            thumbnail: ThumbnailEntity(path: thumbnailPath, extension: thumbnailExt)
        )
    }

    static func mockList(count: Int = 10) -> [CharacterEntity] {
        (1...count).map { i in
            .mock(
                id: i,
                name: "Character \(i)",
                thumbnailPath: "https://marvel.com/character/image"
            )
        }
    }
}
