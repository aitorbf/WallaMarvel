import Foundation

// sourcery: AutoMockable
protocol CharactersRepository {
    func getCharacters(
        offset: Int,
        limit: Int,
        searchText: String
    ) async throws -> CharacterDataContainerEntity
    func getCharacterComics(
        characterId: Int,
        offset: Int,
        limit: Int
    ) async throws -> ComicDataContainerEntity
}

final class CharactersRepositoryImpl {
    
    private let remote: CharactersRemoteDataSource
    
    init(remoteDataSource: CharactersRemoteDataSource) {
        self.remote = remoteDataSource
    }
}

extension CharactersRepositoryImpl: CharactersRepository {
    
    func getCharacters(
        offset: Int,
        limit: Int,
        searchText: String
    ) async throws -> CharacterDataContainerEntity {
        try await remote.getCharacters(
            offset: offset,
            limit: limit,
            searchText: searchText
        )
    }
    
    func getCharacterComics(
        characterId: Int,
        offset: Int,
        limit: Int
    ) async throws -> ComicDataContainerEntity {
        try await remote.getCharacterComics(
            characterId: characterId,
            offset: offset,
            limit: limit
        )
    }
}
