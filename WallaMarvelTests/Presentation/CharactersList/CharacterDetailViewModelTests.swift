//
//  CharacterDetailViewModelTests.swift
//  WallaMarvelTests
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Testing
import SwiftyMocky
@testable import WallaMarvel

@Suite struct CharacterDetailViewModelTests {
    
    private var useCase: GetCharacterComicsUseCaseMock!
    private var viewModel: CharacterDetailViewModelImpl!
    
    init() {
        useCase = GetCharacterComicsUseCaseMock()
        viewModel = CharacterDetailViewModelImpl(
            character: Character.mock(),
            getCharacterComicsUseCase: useCase
        )
    }
    
    @Test("Initial state")
    func testInitialState() {
        #expect(viewModel.isLoadingComics == true)
        #expect(viewModel.comics.isEmpty)
    }
    
    @Test("Get comics successfully")
    func testGetComicsSuccess() async {
        let offset = 0
        let limit = 20
        let total = 100
        let response = ComicsPage.mock(
            offset: offset,
            total: total,
            comics: Comic.mockList(count: limit)
        )
        
        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        await viewModel.getComics()
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(viewModel.isLoadingComics == false)
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response.count)
    }
    
    @Test("Get comics error")
    func testGetComicsError() async {
        let offset = 0
        let limit = 20
        let errorResponse = DataError.serverError
        
        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willThrow: errorResponse
            )
        )
        
        await viewModel.getComics()
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(viewModel.isLoadingComics == false)
        #expect(viewModel.comics.isEmpty)
    }
    
    @Test("Load more comics successfully")
    func testLoadMoreComicsSuccess() async {
        let offset1 = 0
        let limit = 20
        let total = 100
        let response1 = ComicsPage.mock(
            offset: offset1,
            total: total,
            comics: Comic.mockList(count: limit)
        )
        let offset2 = limit
        let response2 = ComicsPage.mock(
            offset: offset2,
            total: total,
            comics: Comic.mockList(count: limit)
        )
        
        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit),
                willReturn: response1
            )
        )
        
        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit),
                willReturn: response2
            )
        )
        
        await viewModel.getComics()
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit)
            )
        )
          
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response1.count)
        
        // When: currentIndex >= threshold
        await viewModel.loadMoreComics(currentIndex: 15)
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == (response1.count + response2.count))
    }
    
    @Test("Not load more comics when below threshold")
    func testNotLoadMoreComicsBelowThreshold() async {
        let offset = 0
        let limit = 20
        let total = 100
        let response = ComicsPage.mock(
            offset: offset,
            total: total,
            comics: Comic.mockList(count: limit)
        )

        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        await viewModel.getComics()
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response.count)
        
        // When: currentIndex < threshold.
        await viewModel.loadMoreComics(currentIndex: 5)
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response.count)
    }
    
    @Test("Not load more comics when reach total")
    func testNoLoadWhenCanFetchMoreComicsFalse() async {
        let offset = 0
        let limit = 20
        let total = 20
        let response = ComicsPage.mock(
            offset: offset,
            total: total,
            comics: Comic.mockList(count: limit)
        )

        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        await viewModel.getComics()
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response.count)
        
        // When: currentIndex >= threshold && canFetchMore == false
        await viewModel.loadMoreComics(currentIndex: 15)
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response.total)
    }
    
    @Test("Load more comics error")
    func testLoadMoreComicsError() async {
        let offset1 = 0
        let limit = 20
        let total = 100
        let response1 = ComicsPage.mock(
            offset: offset1,
            total: total,
            comics: Comic.mockList(count: limit)
        )
        let offset2 = limit
        let errorResponse = DataError.serverError
        
        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit),
                willReturn: response1
            )
        )
        
        Given(
            useCase,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit),
                willThrow: errorResponse
            )
        )
        
        await viewModel.getComics()
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response1.count)
        
        // When: currentIndex >= threshold
        await viewModel.loadMoreComics(currentIndex: 15)
        
        Verify(
            useCase,
            .once,
            .execute(
                characterId: Parameter(integerLiteral: viewModel.character.id),
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.comics.isEmpty)
        #expect(viewModel.comics.count == response1.count)
    }
}
