
// swiftlint:disable force_unwrapping force_try

import Foundation

protocol APIClientProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
}

final class APIClient: APIClientProtocol {
    enum Constant {
        static let privateKey = Bundle.main.infoDictionary?["MARVEL_PRIVATE_API_KEY"] as? String
        static let publicKey = Bundle.main.infoDictionary?["MARVEL_PUBLIC_API_KEY"] as? String
    }
    
    init() { }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey ?? ""
        let publicKey = Constant.publicKey ?? ""
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let parameters: [String: String] = [
            "apikey": publicKey,
            "ts": ts,
            "hash": hash
        ]
        
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data!)
            completionBlock(dataModel)
            print(dataModel)
        }
        .resume()
    }
}

// swiftlint:enable force_unwrapping force_try
