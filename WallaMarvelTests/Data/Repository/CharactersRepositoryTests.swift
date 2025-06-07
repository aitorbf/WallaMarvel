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
        let response = CharacterDataContainerEntity.mock()
        Given(remoteDataSource, .getCharacters(willReturn: response))
        
        Verify(remoteDataSource, .once, .getCharacters())
        
        let result = try await repository.getCharacters()
        
        #expect(result.offset == response.offset)
        #expect(result.total == response.total)
        #expect(result.characters != nil)
        #expect(result.count == result.characters?.count)
        #expect(!(result.characters ?? []).isEmpty)
    }
    
    @Test("Get empty characters list from remote data source")
    func testGetCharactersEmptyContent() async throws {
        let response = CharacterDataContainerEntity.mock(
            offset: 0,
            total: 0,
            characters: []
        )
        Given(remoteDataSource, .getCharacters(willReturn: response))
        
        Verify(remoteDataSource, .once, .getCharacters())
        
        let result = try await repository.getCharacters()
        
        #expect(result.offset == response.offset)
        #expect(result.total == response.total)
        #expect(result.characters != nil)
        #expect(result.count == result.characters?.count)
        #expect((result.characters ?? []).isEmpty)
    }

    @Test("Throws error when remote data source fails")
    func testThrowsErrorWhenRemoteDataSourceFails() async {
        let errorResponse = DataError.serverError
        Given(remoteDataSource, .getCharacters(willThrow: errorResponse))
        
        Verify(remoteDataSource, .once, .getCharacters())

        await #expect(throws: DataError.self) {
            try await repository.getCharacters()
        }
    }
}
