//
//  ProgressBar.swift
//  AssetCleaner
//
//  Created by Nijat Muzaffarli on 2022/09/16.
//

import Foundation

public struct ProgressBar {
    public let width = 60
    private var output: OutputBuffer

    public init(output: OutputBuffer) {
        self.output = output
        self.output.write("")
    }

    public mutating func render(count: Int, total: Int) {
        let progress = Float(count) / Float(total)
        let numberOfBars = Int(floor(progress * Float(width)))
        let numberOfTicks = width - numberOfBars
        let bars = "🁢" * numberOfBars
        let ticks = "-" * numberOfTicks

        let percentage = Int(floor(progress * 100))
        output.clearLine()
        output.write("[\(bars)\(ticks)] \(percentage)%")
    }
}
