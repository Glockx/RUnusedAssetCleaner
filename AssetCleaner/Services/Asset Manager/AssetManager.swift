//
//  AssetManager.swift
//  AssetCleaner
//
//  Created by Nijat Muzaffarli on 2022/09/16.
//

import Foundation

class AssetManager {
    // MARK: - Variables

    /// Shared
    static let shared = AssetManager()

    // MARK: - Get Assets Folder Path

    /// Finding The "Assets.xcassets" Folder In The Project Folder.
    /// The File Manager Enumerator Traverse Through All Folders In The Project Folder.
    /// - Returns: The Folder Path URL Of The "Asset Folder"
    func getAssetFolder() -> URL? {
        // Create Enumartor For Current Directory Path Of Executable
        let enumerator = fileManager.enumerator(atPath: currentDirectoryPath)
        // Check Each File
        while let element = enumerator?.nextObject() as? String {
            // If Path String Contains The "Assets.xcassets", The Asset Folder Has Found
            if element.hasSuffix("Assets.xcassets") {
                // Convert Assets Folder To URL
                let relativeURL = URL(fileURLWithPath: element, relativeTo: URL(fileURLWithPath: currentDirectoryPath))
                let url = relativeURL.absoluteURL
                // Return URL
                return url
            }
        }
        // Return Nil
        return nil
    }

    // MARK: - Get Subdirectories Of Asset Folder

    /// Getting The Subdirectories Of The Asset Folder, Which Also Covers The Sub Directories such as:
    /// (Assets.xcassets --> Example Folder --> Example Folder)
    /// - Parameter folder: The Asset Folder Path
    /// - Returns: The File Paths Of The Image Assets
    func getSubDirectoriesOfAssetFolder(folder: URL) -> [URL]? {
        // Create Enumerator
        let enumerator = fileManager.enumerator(at: folder, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles])
        // File URLS
        var fileURLs: [URL] = []

        // Enumerat Each Item Path
        while let url = enumerator?.nextObject() as? URL {
            // If Path's Extension Is ".imageset" Append To File URLs
            if url.pathExtension == "imageset" {
                fileURLs.append(url)
            }
        }

        // Return File URLs'
        return fileURLs
    }

    // MARK: - Is Asset Used In Code

    /// Finding Unused Image Assets Which Has Extracted From "Assets.xcassets".
    /// Overall Logic is Simple, First Iterating Over All Image Assets by Using the Ripgrep. The Reason for Using Ripgrep is Totally About the Recursive Text Search Performance of the Library. Additionally, By default, ripgrep will respect gitignore rules and automatically skip hidden files/directories and binary files. I Have Tried "Grep", "Ggrep" and Similar Libraries, as Conclusion the Ripgrep is the Most Performant One.
    /// By Sending a Shell Command,  We Are Checking the Result of the Execution, if Result Contains Any Search Result It Means That Image Resource Has Used Through R Library. The recrusive text query is simple: "R.image.\(exampleImage)".
    /// - Parameter assets: Extracted Image Assets
    /// - Returns: Unused Image Assets
    func findUnusedAssets(assets: [Asset]) -> [Asset] {
        var unussedAssets = [Asset]()
        // Start Progress Bar
        progressBar.render(count: 0, total: assets.count)
        print(stringBuffer.string)

        for (index, asset) in assets.enumerated() {
            do {
                // Get File Searching Result With RipGrep
                let result = try AssetManager.shared.safeShell("rg -j 15 -S -c -i --text \"R.image.\(asset.name)\".")
                // If There Is A Result, Add Asset To Unused Assets Array
                if result.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    // print(asset.path)
                    // print("Found unused asset: \(asset.name)")
                    // print("\n")

                    unussedAssets.append(asset)
                }
                // Update Progress Bar
                progressBar.render(count: index + 1, total: assets.count)
                print(stringBuffer.string)
            } catch {
                // Catch Shell Result
                print("\(error)") // handle or silence the error here
            }
        }

        return unussedAssets
    }

    // MARK: - Delete Unused Assets

    /// Deleting The Give Unused Assets.
    /// - Parameter asset: An Array Of Unused Assets
    func deleteUnusedAssets(asset: [Asset]) {
        for asset in asset {
            do {
                try? fileManager.removeItem(at: asset.path)
                print("Deleted asset: \(asset.name)")
            } catch {
                print("Failed To Delete Unused Asset: \(asset.path): \(error))") // handle or silence the error here
            }
        }
    }

    // MARK: - Calculate Assets Size

    /// Calculating Folder Size Of The Each Asset on The Disk Space.
    /// - Parameter assets: An Array Of Assets
    func calculateAssetSize(assets: [Asset]) {
        print("\n")
        // Map File Path of asset files.
        let urls = assets.map(\.path)
        // Total Size Of Files
        var totalSize = 0
        // Dictionary Of File And Its' Size. This Value Is Useful For Later Usage, Such As Sorting Files by Allocated disk size and etc.
        var sizes = [URL: Int]()

        for url in urls {
            // Check The Allocated Size
            if let allocatedSize = try? url.directoryTotalAllocatedSize(includingSubfolders: true) {
                // Add To Toal Size
                totalSize += allocatedSize
                // Set To Dictionary
                sizes[url, default: 0] = allocatedSize
            }
        }

        // Convert Total Size Of Allocated Asset Folder Sizes To Textual Representation.
        if let size = byteCountFormatter.string(for: totalSize) {
            print("Total Unused Assets Size:", size)
        }
    }

    // MARK: - A safe Shell Command Execution

    // Add to suppress warnings when you don't want/need a result
    @discardableResult
    /// Send A Safe To Fail Shell Command.
    /// - Parameter command: The Command String.
    /// - Returns: The Result Of The Command Execution As String.
    func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()

        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh") // <--updated
        task.standardInput = nil

        try task.run()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    }

    // MARK: - Save JSON File To Documents Directory

    /// Save The JSON String To The Documents Folder
    /// - Parameter jsonString: A Json String Of Give Data
    func saveToDocumentDirectory(_ jsonString: String?) {
        // Get The File Path Of Documents Directory
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // Add File Output Path
        let fileURL = path.appendingPathComponent("Output.json")

        // Write File To The Documents
        do {
            try jsonString?.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Result File Has Saved To: /Documents")
        } catch {
            print("Failed To Save Result File To The Desktop")
            print(error.localizedDescription)
        }
    }

    // MARK: - Save JSON File To Desktop

    func saveToDesktop(_ jsonString: String?) {
        // Get Home Directory
        let homeURL = FileManager.default.homeDirectoryForCurrentUser
        // Get Desktop Directory
        let desktopURL = homeURL.appendingPathComponent("Desktop")
        // Add File Output Path
        let fileURL = desktopURL.appendingPathComponent("Output.json")

        do {
            // Write File To The Desktop
            try jsonString?.write(to: fileURL, atomically: true, encoding: .utf8)
            print("Result File Has Saved To: ", fileURL.path)
        } catch {
            print("Failed To Save Result File To The Desktop")
            print(error.localizedDescription)
        }
    }
}
