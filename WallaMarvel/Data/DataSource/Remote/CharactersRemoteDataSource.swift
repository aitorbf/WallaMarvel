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
    func getCharacterComics(
        characterId: Int,
        offset: Int,
        limit: Int
    ) async throws -> ComicDataContainerEntity
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
    
    func getCharacterComics(
        characterId: Int,
        offset: Int,
        limit: Int
    ) async throws -> ComicDataContainerEntity {
        guard let request = API.Marvel.CharactersAPI.getCharacterComics(characterId: characterId, offset: offset, limit: limit).urlRequest else {
            throw DataError.invalidUrl
        }
        return try await RemoteDataSource.run(request)
    }
}
