//
//  Devices.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import UIKit
import SnapshotTesting

enum Devices {
    static let list: [String: ViewImageConfig] = [
        "iPhoneSE": .iPhoneSe,
        "iPhoneSELandscape": .iPhoneSe(.landscape),
        "iPhone13": .iPhone13,
        "iPhone13Landscape": .iPhone13(.landscape),
        "iPhone13Pro": .iPhone13Pro,
        "iPhone13ProLandscape": .iPhone13Pro(.landscape),
        "iPhone13ProMax": .iPhone13ProMax,
        "iPhone13ProMaxLandscape": .iPhone13ProMax(.landscape),
    ]
}
