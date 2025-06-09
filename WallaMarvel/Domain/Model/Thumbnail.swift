//
//  Thumbnail.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 9/6/25.
//

import Foundation

struct Thumbnail {
    
    let standard: String
    let portrait: String
    let landscape: String
}

extension Thumbnail {
    
    static func mock(
        path: String = "http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55",
        extension: String = "jpg"
    ) -> Thumbnail {
        Thumbnail(
            standard: "\(path)/standard_medium.\(`extension`)",
            portrait: "\(path)/portrait_xlarge.\(`extension`)",
            landscape: "\(path)/landscape_xlarge.\(`extension`)"
        )
    }
}
