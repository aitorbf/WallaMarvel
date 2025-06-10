//
//  MarvelAPI.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

extension API.Marvel {
    
    enum CharactersAPI: URLRequestConvertible {
        
        case getCharacters(offset: Int, limit: Int, searchText: String)
        case getCharacterComics(characterId: Int, offset: Int, limit: Int)
        
        var method: HttpConstants.Method {
            switch self {
            case .getCharacters, .getCharacterComics:
                return .get
            }
        }
        
        var endpoint: String {
            switch self {
            case .getCharacters:
                return HttpConstants.marvelServiceBaseURL + "characters"
            case let .getCharacterComics(characterId, _, _):
                return HttpConstants.marvelServiceBaseURL + "characters/\(characterId)/comics"
            }
        }
        
        func addParameters(toUrlComponents urlComponents: inout URLComponents) {
            let ts = String(Int(Date().timeIntervalSince1970))
            let privateKey = Bundle.main.infoDictionary?["MARVEL_PRIVATE_API_KEY"] as? String ?? ""
            let publicKey = Bundle.main.infoDictionary?["MARVEL_PUBLIC_API_KEY"] as? String ?? ""
            let hash = "\(ts)\(privateKey)\(publicKey)".md5
            var parameters: [String: String] = [
                "apikey": publicKey,
                "ts": ts,
                "hash": hash
            ]
            
            switch self {
            case let .getCharacters(offset, limit, searchText):
                parameters["offset"] = String(offset)
                parameters["limit"] = String(limit)
                if !searchText.isEmpty {
                    parameters["nameStartsWith"] = searchText
                }
            case let .getCharacterComics(_, offset, limit):
                parameters["offset"] = String(offset)
                parameters["limit"] = String(limit)
            }
            
            urlComponents.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
    }
}
