//
//  ComicsPage.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import Foundation

struct ComicsPage {
    
    let offset: Int
    let count: Int
    let total: Int
    let comics: [Comic]
}

// swiftlint:disable no_magic_numbers
extension ComicsPage {
    
    static func mock(
        offset: Int = 0,
        total: Int = 20,
        comics: [Comic] = Comic.mockList(count: 20)
    ) -> ComicsPage {
        ComicsPage(
            offset: offset,
            count: comics.count,
            total: total,
            comics: comics
        )
    }
}
// swiftlint:enable no_magic_numbers
