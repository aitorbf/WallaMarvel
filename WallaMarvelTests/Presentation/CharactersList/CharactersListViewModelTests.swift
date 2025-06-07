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
        let response = CharactersPage.mock()
        Given(useCase, .execute(willReturn: response))
        
        Verify(useCase, .once, .execute())
        
        await viewModel.getCharacters()
        
        #expect(viewModel.isLoading == false)
        #expect(!viewModel.characters.isEmpty)
        #expect(viewModel.characters.count == response.characters.count)
    }

    @Test("Handle error when getting characters")
    func testHandleError() async {
        let errorResponse = DataError.serverError
        Given(useCase, .execute(willThrow: errorResponse))
        
        Verify(useCase, .once, .execute())
        
        await viewModel.getCharacters()
        
        #expect(viewModel.isLoading == false)
        #expect(viewModel.characters.isEmpty)
    }
}
