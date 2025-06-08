//
//  GetCharactersUseCaseTests.swift
//  WallaMarvelTests
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import Testing
import SwiftyMocky
@testable import WallaMarvel

@Suite struct GetCharactersUseCaseTests {
    
    private var repository: CharactersRepositoryMock!
    private var useCase: GetCharactersUseCase!

    init() {
        repository = CharactersRepositoryMock()
        useCase = GetCharactersUseCaseImpl(repository: repository)
    }

    @Test("Get characters page")
    func testGetCharactersPage() async throws {
        let offset = 0
        let limit = 20
        let total = 100
        let response = CharacterDataContainerEntity.mock(
            offset: offset,
            total: total,
            characters: CharacterEntity.mockList(count: limit)
        )
        
        Given(
            repository,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == response.count)
        #expect(!result.characters.isEmpty)
    }
    
    @Test("Get empty characters page")
    func testGetCharactersEmptyPage() async throws {
        let offset = 0
        let limit = 20
        let total = 0
        let response = CharacterDataContainerEntity.mock(
            offset: offset,
            total: total,
            characters: []
        )
        
        Given(
            repository,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == total)
        #expect(result.characters.isEmpty)
    }
    
    @Test("Data mapping from entity to model")
    func testDataMapping() async throws {
        let offset = 0
        let limit = 20
        let total = 1
        let thumbnailUrl = "thumbnailPath/standard_medium.jpg"
        let characterEntity: CharacterEntity = .mock(
            thumbnailPath: "thumbnailPath",
            thumbnailExt: "jpg"
        )
        let response = CharacterDataContainerEntity.mock(
            offset: offset,
            total: total,
            characters: [characterEntity]
        )
        
        Given(
            repository,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == total)
        #expect(result.characters.count == total)
        
        #expect(result.characters.first?.id == characterEntity.id)
        #expect(result.characters.first?.name == characterEntity.name)
        #expect(result.characters.first?.thumbnail == thumbnailUrl)
    }
    
    @Test("Data mapping with nil values")
    func testDataMappingWithNilValues() async throws {
        let offset = 0
        let limit = 20
        let total = 1
        let characterEntity: CharacterEntity = .mock(
            name: nil,
            thumbnailPath: nil,
            thumbnailExt: "jpg"
        )
        let response = CharacterDataContainerEntity.mock(
            offset: offset,
            total: total,
            characters: [characterEntity]
        )
        
        Given(
            repository,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == total)
        #expect(result.characters.count == total)
        
        #expect(result.characters.first?.id == characterEntity.id)
        #expect(result.characters.first?.name == "")
        #expect(result.characters.first?.thumbnail == "")
    }

    @Test("Throws error when repository fails")
    func testThrowsErrorWhenRepositoryFails() async {
        let offset = 0
        let limit = 20
        let errorResponse = DataError.serverError
        
        Given(
            repository,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willThrow: errorResponse
            )
        )

        await #expect(throws: DataError.self) {
            try await useCase.execute(offset: offset, limit: limit)
        }
        
        Verify(
            repository,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
    }
}
