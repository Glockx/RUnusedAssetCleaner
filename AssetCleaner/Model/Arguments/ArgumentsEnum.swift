//
//  ArgumentsEnum.swift
//  AssetCleaner
//
//  Created by spresto on 2022/09/16.
//

import Foundation

/// An Enum That Contains The Arguments:
/// 1. ShouldDeleteUnusedAssets: Should Delete All Unsed Assets
enum ArgumentsEnum: String, CaseIterable, Hashable, Equatable {
    /// Should Delete All Unsed Assets
    case shouldDeleteUnusedAssets = "-d"
    /// Save Result To Desktop
    case saveResultToDesktop = "-s"
}
