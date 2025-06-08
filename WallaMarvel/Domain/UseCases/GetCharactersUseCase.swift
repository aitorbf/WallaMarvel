import Foundation

// sourcery: AutoMockable
protocol GetCharactersUseCase {
    func execute(
        offset: Int,
        limit: Int,
        searchText: String
    ) async throws -> CharactersPage
}

struct GetCharactersUseCaseImpl: GetCharactersUseCase {
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func execute(
        offset: Int,
        limit: Int,
        searchText: String
    ) async throws -> CharactersPage {
        let characterDataContainer = try await repository.getCharacters(
            offset: offset,
            limit: limit,
            searchText: searchText
        )
        return CharactersPageMapper.map(characterDataContainer)
    }
}
