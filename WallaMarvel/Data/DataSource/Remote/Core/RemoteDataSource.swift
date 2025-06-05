//
//  RemoteDataSource.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 4/6/25.
//

import Foundation

struct RemoteDataSource {
    
    private init() {
        // Intentionally empty
    }
    
    static func run<T: Decodable>(_ urlRequest: URLRequest) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            try processResponse(response)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DataError.decoding
        }
    }
}

private extension RemoteDataSource {
    
    static func processResponse(_ response: URLResponse) throws {
        if let response: HTTPURLResponse = response as? HTTPURLResponse {
            if let error = checkStatusCodeFromResponse(response) { throw error }
        }
    }
    
    static func checkStatusCodeFromResponse(_ response: HTTPURLResponse) -> DataError? {
        var error: DataError?
        switch response.statusCode {
        case HttpConstants.StatusCode.ok:
            break
        case HttpConstants.StatusCode.clientError:
            error = .clientError
        case HttpConstants.StatusCode.serverError:
            error = .serverError
        default:
            error = .unknown
        }
        return error
    }
}
