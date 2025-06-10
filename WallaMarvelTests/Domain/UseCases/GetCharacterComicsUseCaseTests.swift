//
//  GetCharacterComicsUseCaseTests.swift
//  WallaMarvelTests
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Testing
import SwiftyMocky
@testable import WallaMarvel

@Suite struct GetCharacterComicsUseCaseTests {
    
    private var repository: CharactersRepositoryMock!
    private var useCase: GetCharacterComicsUseCase!

    init() {
        repository = CharactersRepositoryMock()
        useCase = GetCharacterComicsUseCaseImpl(repository: repository)
    }

    @Test("Get character comics page")
    func testGetCharacterComicsPage() async throws {
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
            repository,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(characterId: characterId, offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == response.count)
        #expect(!result.comics.isEmpty)
    }
    
    @Test("Get empty character comics page")
    func testGetCharactersEmptyPage() async throws {
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
            repository,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(characterId: characterId, offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == total)
        #expect(result.comics.isEmpty)
    }
    
    @Test("Data mapping from entity to model")
    func testDataMapping() async throws {
        let characterId = 1
        let offset = 0
        let limit = 20
        let total = 1
        let standardThumbnailUrl = "thumbnailPath/standard_medium.jpg"
        let portraitThumbnailUrl = "thumbnailPath/portrait_xlarge.jpg"
        let landscapeThumbnailUrl = "thumbnailPath/landscape_xlarge.jpg"
        let comicEntity: ComicEntity = .mock(
            thumbnailPath: "thumbnailPath",
            thumbnailExt: "jpg"
        )
        let response = ComicDataContainerEntity.mock(
            offset: offset,
            total: total,
            comics: [comicEntity]
        )
        
        Given(
            repository,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(characterId: characterId, offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == total)
        #expect(result.comics.count == total)
        
        #expect(result.comics.first?.id == comicEntity.id)
        #expect(result.comics.first?.title == comicEntity.title)
        #expect(result.comics.first?.description == comicEntity.description)
        #expect(result.comics.first?.pages == comicEntity.pageCount)
        #expect(result.comics.first?.thumbnail.standard == standardThumbnailUrl)
        #expect(result.comics.first?.thumbnail.portrait == portraitThumbnailUrl)
        #expect(result.comics.first?.thumbnail.landscape == landscapeThumbnailUrl)
    }
    
    @Test("Data mapping with nil values")
    func testDataMappingWithNilValues() async throws {
        let characterId = 1
        let offset = 0
        let limit = 20
        let total = 1
        let comicEntity: ComicEntity = .mock(
            title: nil,
            description: nil,
            pageCount: nil,
            thumbnailPath: nil,
            thumbnailExt: "jpg"
        )
        let response = ComicDataContainerEntity.mock(
            offset: offset,
            total: total,
            comics: [comicEntity]
        )
        
        Given(
            repository,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        let result = try await useCase.execute(characterId: characterId, offset: offset, limit: limit)
        
        Verify(
            repository,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(result.offset == offset)
        #expect(result.total == total)
        #expect(result.count == total)
        #expect(result.comics.count == total)
        
        #expect(result.comics.first?.id == comicEntity.id)
        #expect(result.comics.first?.title == "")
        #expect(result.comics.first?.description == "")
        #expect(result.comics.first?.pages == 0)
        #expect(result.comics.first?.thumbnail.standard == "")
        #expect(result.comics.first?.thumbnail.portrait == "")
        #expect(result.comics.first?.thumbnail.landscape == "")
    }

    @Test("Throws error when repository fails")
    func testThrowsErrorWhenRepositoryFails() async {
        let characterId = 1
        let offset = 0
        let limit = 20
        let errorResponse = DataError.serverError
        
        Given(
            repository,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willThrow: errorResponse
            )
        )

        await #expect(throws: DataError.self) {
            try await useCase.execute(characterId: characterId, offset: offset, limit: limit)
        }
        
        Verify(
            repository,
            .once,
            .getCharacterComics(
                characterId: Parameter(integerLiteral: characterId),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
    }
}
