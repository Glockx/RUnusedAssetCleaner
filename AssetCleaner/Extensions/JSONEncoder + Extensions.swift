//
//  JSONEncoder + Extensions.swift
//  AssetCleaner
//
//  Created by spresto on 2022/09/16.
//

import Foundation

extension JSONEncoder {
    static func toJsonString<T: Encodable>(from data: T) -> String? {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let json = try jsonEncoder.encode(data)
            return String(data: json, encoding: .utf8)?.replacingOccurrences(of: "\\", with: "")
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
