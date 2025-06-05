//
//  URLRequestConvertible.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

protocol URLRequestConvertible {
    var method: HttpConstants.Method { get }
    var endpoint: String { get }
    
    func addParameters(toUrlComponents urlComponents: inout URLComponents)
}

extension URLRequestConvertible {
    
    var urlRequest: URLRequest? { asURLRequest() }
    
    private func asURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: endpoint) else {
            return nil
        }
        
        addParameters(toUrlComponents: &urlComponents)
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
