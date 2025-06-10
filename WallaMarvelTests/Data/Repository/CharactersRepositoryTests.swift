//
//  CharactersRepositoryTests.swift
//  WallaMarvelTests
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import Testing
import SwiftyMocky
@testable import WallaMarvel

@Suite struct CharactersRepositoryTests {
    
    private var remoteDataSource: CharactersRemoteDataSourceMock!
    private var repository: CharactersRepository!

    init() {
        remoteDataSource = CharactersRemoteDataSourceMock()
        repository = CharactersRepositoryImpl(remoteDataSource: remoteDataSource)
    }

    @Test("Get characters list from remote data source")
    func testGetCharactersContent() async throws {
        let offset = 0
        let limit = 20
        let total = 100
        let response = CharacterDataContainerEntity.mock(
            offset: offset,
            total: total,
            characters: CharacterEntity.mockList(count: limit)
        )
        
        Given(
            remoteDataSource,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                searchText: "",
                willReturn: response
            )
        )
        
        let result = try await repository.getCharacters(offset: offset, limit: limit, searchText: "")
        
        Verify(
            remoteDataSource,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                searchText: ""
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.characters != nil)
        #expect(!(result.characters ?? []).isEmpty)
        #expect(result.count == response.count)
    }
    
    @Test("Get empty characters list from remote data source")
    func testGetCharactersEmptyContent() async throws {
        let offset = 0
        let limit = 20
        let total = 0
        let response = CharacterDataContainerEntity.mock(
            offset: offset,
            total: total,
            characters: []
        )
        
        Given(
            remoteDataSource,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                searchText: "",
                willReturn: response
            )
        )
        
        let result = try await repository.getCharacters(offset: offset, limit: limit, searchText: "")
        
        Verify(
            remoteDataSource,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                searchText: ""
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.characters != nil)
        #expect((result.characters ?? []).isEmpty)
        #expect(result.count == total)
    }
    
    @Test("Get character comics from remote data source")
    func testGetCharacterComicsContent() async throws {
        let characterId = 1
        let offset = 0
        let limit = 20
        let total = 100
        let response = ComicDataContainerEntity.mock(
            offset: offset,
            total: total,
            comics: ComicEntity.mockList(count: limit)
        )
        
        Given(
            remoteDataSource,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await repository.getCharacterComics(characterId: characterId, offset: offset, limit: limit)
        
        Verify(
            remoteDataSource,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.comics != nil)
        #expect(!(result.comics ?? []).isEmpty)
        #expect(result.count == response.count)
    }
    
    @Test("Get empty character comics list from remote data source")
    func testGetCharacterComicsEmptyContent() async throws {
        let characterId = 1
        let offset = 0
        let limit = 20
        let total = 0
        let response = ComicDataContainerEntity.mock(
            offset: offset,
            total: total,
            comics: []
        )
        
        Given(
            remoteDataSource,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await repository.getCharacterComics(characterId: characterId, offset: offset, limit: limit)
        
        Verify(
            remoteDataSource,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.comics != nil)
        #expect((result.comics ?? []).isEmpty)
        #expect(result.count == total)
    }

    @Test("Throws error when remote data source fails")
    func testThrowsErrorWhenRemoteDataSourceFails() async {
        let offset = 0
        let limit = 20
        let errorResponse = DataError.serverError
        
        Given(
            remoteDataSource,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                searchText: "",
                willThrow: errorResponse
            )
        )

        await #expect(throws: DataError.self) {
            try await repository.getCharacters(offset: offset, limit: limit, searchText: "")
        }
        
        Verify(
            remoteDataSource,
            .once,
            .getCharacters(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                searchText: ""
            )
        )
    }
}
