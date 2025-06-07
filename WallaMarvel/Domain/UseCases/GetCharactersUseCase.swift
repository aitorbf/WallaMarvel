import Foundation

// sourcery: AutoMockable
protocol GetCharactersUseCase {
    func execute() async throws -> CharactersPage
}

struct GetCharactersUseCaseImpl: GetCharactersUseCase {
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> CharactersPage {
        let characterDataContainer = try await repository.getCharacters()
        return CharactersPageMapper.map(characterDataContainer)
    }
}
