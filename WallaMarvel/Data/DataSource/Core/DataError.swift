//
//  DataError.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 5/6/25.
//

import Foundation

enum DataError: Error, Equatable {
    
    case invalidUrl
    case decoding
    case clientError
    case serverError
    case unknown
}
