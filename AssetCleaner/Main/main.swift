//
//  main.swift
//  AssetCleaner
//
//  Created by Nijat Muzaffarli on 2022/09/15.
//

import Foundation

// MARK: - Variables

/// File Manager
let fileManager = FileManager.default

/// Current directory Path Of Executable
let currentDirectoryPath = fileManager.currentDirectoryPath

/// Byte Count Formatter
let byteCountFormatter = ByteCountFormatter()

/// Progress Bar String Buffer
var stringBuffer: StringBuffer = .init()

/// Progress Bar
var progressBar: ProgressBar = .init(output: stringBuffer)

/// Need To Delete Unused Assets
var shouldDeleteUnusedAssets = false

/// Should Save Resulf
var shouldSaveResult = true

// MARK: - Main

func main() {
    // Set Bye Counter Format
    byteCountFormatter.countStyle = .file

    // Get Arguments
    let arguments = CommandLine.arguments
    // Iterate Each Argument
    for argument in arguments {
        // Print Arguments
        // print(argument)

        // Check Argument
        switch argument {
        // Delete Resource Argument
        case ArgumentsEnum.shouldDeleteUnusedAssets.rawValue:
            // Set Need To Clean
            shouldDeleteUnusedAssets = true
        case ArgumentsEnum.saveResultToDesktop.rawValue:
            // Set Need To Save Result
            shouldSaveResult = true
        default:
            break
        }
    }

    // Get Assets Folder
    if let assetFolder = AssetManager.shared.getAssetFolder() {
        // Get Subdirectories Of Asset Folder,
        // Convert Assets Folder To Asset Model,
        // Filter All Non Image Asset Models
        let assets = AssetManager.shared.getSubDirectoriesOfAssetFolder(folder: assetFolder)?
            .compactMap { Asset(name: $0.deletingPathExtension().lastPathComponent, path: $0) }
            .filter { $0.path.pathExtension == "imageset" } ?? []

        // Find Unsued Asset
        let unussedAssets = AssetManager.shared.findUnusedAssets(assets: assets)

        // If Needed, Convert Assets To Json String and Save To Desktop
        if let jsonString = JSONEncoder.toJsonString(from: unussedAssets), shouldSaveResult {
            AssetManager.shared.saveToDesktop(jsonString)
        }

        // If Need To Delete Unused Resources
        if shouldDeleteUnusedAssets {
            AssetManager.shared.deleteUnusedAssets(asset: unussedAssets)
        }

        // Get Size Of Unsed Asset
        AssetManager.shared.calculateAssetSize(assets: unussedAssets)

    } else {
        print("No Asset Folder Found, Check The Image Asset Cleaner Location")
    }
}

// Start Program
main()
