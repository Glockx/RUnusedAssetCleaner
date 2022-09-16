//
//  StringBuffer.swift
//  AssetCleaner
//
//  Created by spresto on 2022/09/16.
//

import Foundation

public class StringBuffer: OutputBuffer {
    public private(set) var string = ""

    public func write(_ text: String) {
        string.append(text)
    }

    public func clearLine() {
        string = ""
    }
}

extension FileHandle: OutputBuffer {
    public func write(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }
        write(data)
    }

    public func clearLine() {
        write("\r")
    }
}
