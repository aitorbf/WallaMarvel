//
//  CharactersListUIGroup.swift
//  WallaMarvel
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//


import UIKit
import SnapshotTesting

final class CharactersListUIGroup: UIGroup {
    
    static var identifier = "charactersList"
    
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
