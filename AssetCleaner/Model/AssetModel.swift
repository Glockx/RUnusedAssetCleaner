//
//  AssetModel.swift
//  AssetCleaner
//
//  Created by spresto on 2022/09/16.
//

import Foundation

/// Asset Model For Image Assets
struct Asset: Codable, Equatable, Hashable {
    /// Name Of The Asset
    var name: String

    /// File Path Of The Asset Folder
    var path: URL
}
