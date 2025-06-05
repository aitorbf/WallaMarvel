import Foundation

protocol CharactersRepository {
    func getCharacters() async throws -> CharacterDataContainerEntity
}

final class CharactersRepositoryImpl {
    
    private let remote: CharactersRemoteDataSource
    
    init(remoteDataSource: CharactersRemoteDataSource = CharactersRemoteDataSourceImpl()) {
        self.remote = remoteDataSource
    }
}

extension CharactersRepositoryImpl: CharactersRepository {
    
    func getCharacters() async throws -> CharacterDataContainerEntity {
        try await remote.getCharacters()
    }
}
