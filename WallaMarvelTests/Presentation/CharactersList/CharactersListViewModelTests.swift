//
//  CharactersListViewModelTests.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import Testing
import SwiftyMocky
@testable import WallaMarvel

@Suite struct CharactersListViewModelTests {
    
    private var useCase: GetCharactersUseCaseMock!
    private var viewModel: CharactersListViewModelImpl!
    
    init() {
        useCase = GetCharactersUseCaseMock()
        viewModel = CharactersListViewModelImpl(getCharactersUseCase: useCase)
    }
    
    @Test("Initial state")
    func testInitialState() {
        #expect(viewModel.isLoading == true)
        #expect(viewModel.characters.isEmpty)
    }
    
    @Test("Get characters successfully")
    func testGetCharactersSuccess() async {
        let offset = 0
        let limit = 50
        let total = 100
        let response = CharactersPage.mock(
            offset: offset,
            total: total,
            characters: Character.mockList(count: limit)
        )
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        await viewModel.getCharacters()
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(viewModel.isLoading == false)
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response.count)
    }
    
    @Test("Get characters error")
    func testGetCharactersError() async {
        let offset = 0
        let limit = 50
        let errorResponse = DataError.serverError
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willThrow: errorResponse
            )
        )
        
        await viewModel.getCharacters()
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(viewModel.isLoading == false)
        #expect(viewModel.characters.isEmpty)
    }
    
    @Test("Load more characters successfully")
    func testLoadMoreCharactersSuccess() async {
        let offset1 = 0
        let limit = 50
        let total = 100
        let response1 = CharactersPage.mock(
            offset: offset1,
            total: total,
            characters: Character.mockList(count: limit)
        )
        let offset2 = limit
        let response2 = CharactersPage.mock(
            offset: offset2,
            total: total,
            characters: Character.mockList(count: limit)
        )
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit),
                willReturn: response1
            )
        )
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit),
                willReturn: response2
            )
        )
        
        await viewModel.getCharacters()
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response1.count)
        
        // When: currentIndex >= threshold
        await viewModel.loadMoreCharacters(currentIndex: 40)
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(viewModel.characters.count == (response1.count + response2.count))
    }
    
    @Test("Not load more characters when below threshold")
    func testNotLoadMoreCharactersBelowThreshold() async {
        let offset = 0
        let limit = 50
        let total = 100
        let response = CharactersPage.mock(
            offset: offset,
            total: total,
            characters: Character.mockList(count: limit)
        )

        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )

        await viewModel.getCharacters()
        
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response.count)
        
        // When: currentIndex < threshold.
        await viewModel.loadMoreCharacters(currentIndex: 10)
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response.count)
    }
    
    @Test("Not load more characters when reach total")
    func testNoLoadWhenCanFetchMoreFalse() async {
        let offset = 0
        let limit = 50
        let total = 50
        let response = CharactersPage.mock(
            offset: offset,
            total: total,
            characters: Character.mockList(count: 50)
        )
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit),
                willReturn: response
            )
        )
        
        await viewModel.getCharacters()
        
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response.count)
        
        // When: currentIndex >= threshold && canFetchMore == false
        await viewModel.loadMoreCharacters(currentIndex: 40)
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response.total)
    }
    
    @Test("Load more characters error")
    func testLoadMoreCharactersError() async {
        let offset1 = 0
        let limit = 50
        let total = 100
        let response1 = CharactersPage.mock(
            offset: offset1,
            total: total,
            characters: Character.mockList(count: limit)
        )
        let offset2 = limit
        let errorResponse = DataError.serverError
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit),
                willReturn: response1
            )
        )
        
        Given(
            useCase,
            .execute(
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit),
                willThrow: errorResponse
            )
        )
        
        await viewModel.getCharacters()
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset1),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response1.count)
        
        // When: currentIndex >= threshold
        await viewModel.loadMoreCharacters(currentIndex: 40)
        
        Verify(
            useCase,
            .once,
            .execute(
                offset: Parameter(integerLiteral: offset2),
                limit: Parameter(integerLiteral: limit)
            )
        )
        
        #expect(viewModel.characters.count == response1.count)
    }
}
