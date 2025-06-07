//
//  UIGroup.swift
//  WallaMarvelSnapshotTests
//
//  Created by Aitor Baragaño Fernández on 7/6/25.
//

import UIKit
import SnapshotTesting

protocol UIGroup {
    static var identifier: String { get set }
    
    /// Captures snapshots of a view controller for visual regression testing.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to snapshot.
    ///   - name: The name to identify the snapshot.
    ///   - record: Set to `true` to record a new reference snapshot, or `false` to compare against the existing one.
    static func screenshots(
        _ viewController: UIViewController,
        name: String,
        record: Bool
    )
}
