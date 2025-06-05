import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute() async throws -> CharacterDataContainerEntity
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository = CharactersRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() async throws -> CharacterDataContainerEntity {
        try await repository.getCharacters()
    }
}
