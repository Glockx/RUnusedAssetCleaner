//
//  String + Extensions.swift
//  AssetCleaner
//
//  Created by Nijat Muzaffarli on 2022/09/16.
//

import Foundation

extension String {
    static func * (char: String, count: Int) -> String {
        var s = ""
        for _ in 0 ..< count {
            s.append(char)
        }
        return s
    }
}
