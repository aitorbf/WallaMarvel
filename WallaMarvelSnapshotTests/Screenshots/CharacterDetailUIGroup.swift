//
//  CharacterDetailUIGroup.swift
//  WallaMarvelSnapshotTests
//
//  Created by Aitor Baragaño Fernández on 10/6/25.
//

import UIKit
import SnapshotTesting

final class CharacterDetailUIGroup: UIGroup {
    
    static var identifier = "characterDetail"
    
    static func screenshots(
        _ viewController: UIViewController,
        name: String,
        record: Bool = false
    ) {
        Devices.list.forEach { device in
            let snapshotName = "\(identifier)-\(name)-\(device.key)"
            assertSnapshot(
                of: viewController,
                as: .image(on: device.value),
                named: snapshotName,
                record: record
            )
        }
    }
}
