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
        
        var method: HttpConstants.Method {
            switch self {
            case .getCharacters:
                return .get
            }
        }
        
        var endpoint: String {
            switch self {
            case .getCharacters:
                return HttpConstants.marvelServiceBaseURL + "characters"
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
            }
            
            urlComponents.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
    }
}
