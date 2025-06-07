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
        let response = CharacterDataContainerEntity.mock()
        Given(repository, .getCharacters(willReturn: response))
        
        Verify(repository, .once, .getCharacters())
        
        let result = try await useCase.execute()
        
        #expect(result.offset == response.offset)
        #expect(result.total == response.total)
        #expect(result.count == result.characters.count)
        #expect(!result.characters.isEmpty)
    }
    
    @Test("Get empty characters page")
    func testGetCharactersEmptyPage() async throws {
        let response = CharacterDataContainerEntity.mock(
            offset: 0,
            total: 0,
            characters: []
        )
        Given(repository, .getCharacters(willReturn: response))
        
        Verify(repository, .once, .getCharacters())
        
        let result = try await useCase.execute()
        
        #expect(result.offset == response.offset)
        #expect(result.total == response.total)
        #expect(result.count == result.characters.count)
        #expect(result.characters.isEmpty)
    }
    
    @Test("Data mapping from entity to model")
    func testDataMapping() async throws {
        let characterEntity: CharacterEntity = .mock(thumbnailPath: "thumbnailPath", thumbnailExt: "jpg")
        let response = CharacterDataContainerEntity.mock(
            offset: 0,
            total: 1,
            characters: [characterEntity]
        )
        Given(repository, .getCharacters(willReturn: response))
        
        Verify(repository, .once, .getCharacters())
        
        let result = try await useCase.execute()
        
        #expect(result.offset == response.offset)
        #expect(result.total == response.total)
        #expect(result.count == result.characters.count)
        #expect(result.characters.count == 1)
        
        #expect(result.characters.first?.id == characterEntity.id)
        #expect(result.characters.first?.name == characterEntity.name)
        #expect(result.characters.first?.thumbnail == "thumbnailPath/standard_medium.jpg")
    }
    
    @Test("Data mapping with nil values")
    func testDataMappingWithNilValues() async throws {
        let characterEntity: CharacterEntity = .mock(
            name: nil,
            thumbnailPath: nil,
            thumbnailExt: "jpg"
        )
        let response = CharacterDataContainerEntity.mock(
            offset: 0,
            total: 1,
            characters: [characterEntity]
        )
        Given(repository, .getCharacters(willReturn: response))
        
        Verify(repository, .once, .getCharacters())
        
        let result = try await useCase.execute()
        
        #expect(result.offset == response.offset)
        #expect(result.total == response.total)
        #expect(result.count == result.characters.count)
        #expect(result.characters.count == 1)
        
        #expect(result.characters.first?.id == characterEntity.id)
        #expect(result.characters.first?.name == "")
        #expect(result.characters.first?.thumbnail == "")
    }

    @Test("Throws error when repository fails")
    func testThrowsErrorWhenRepositoryFails() async {
        let errorResponse = DataError.serverError
        Given(repository, .getCharacters(willThrow: errorResponse))
        
        Verify(repository, .once, .getCharacters())

        await #expect(throws: DataError.self) {
            try await useCase.execute()
        }
    }
}
