//
//  CharactersRemoteDataSource.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

// sourcery: AutoMockable
protocol CharactersRemoteDataSource {
    func getCharacters(
        offset: Int,
        limit: Int,
        searchText: String
    ) async throws -> CharacterDataContainerEntity
}

final class CharactersRemoteDataSourceImpl: CharactersRemoteDataSource {
    
    func getCharacters(
        offset: Int,
        limit: Int,
        searchText: String
    ) async throws -> CharacterDataContainerEntity {
        guard let request = API.Marvel.CharactersAPI.getCharacters(offset: offset, limit: limit, searchText: searchText).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await RemoteDataSource.run(request)
    }
}
