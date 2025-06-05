//
//  HttpConstants.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 4/6/25.
//
// swiftlint:disable no_magic_numbers

import Foundation

enum HttpConstants {
    static let marvelServiceBaseURL = "https://gateway.marvel.com:443/v1/public/"
}

extension HttpConstants {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum StatusCode {
        static let ok = 200...299
        static let clientError = 400...499
        static let serverError = 500...599
    }
}

// swiftlint:enable no_magic_numbers
