//
//  OutputBuffer.swift
//  AssetCleaner
//
//  Created by Nijat Muzaffarli on 2022/09/16.
//

import Foundation

public protocol OutputBuffer {
    mutating func write(_ text: String)
    mutating func clearLine()
}
