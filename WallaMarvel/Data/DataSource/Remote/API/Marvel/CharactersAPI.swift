//
//  MarvelAPI.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

extension API.Marvel {
    
    enum CharactersAPI: URLRequestConvertible {
        
        case getCharacters
        
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
            let parameters: [String: String] = [
                "apikey": publicKey,
                "ts": ts,
                "hash": hash
            ]
            
            urlComponents.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
    }
}
