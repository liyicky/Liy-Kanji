//
//  PrintExtensions.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/15.
//
// PiterPan https://stackoverflow.com/questions/39026752/swift-extending-functionality-of-print-function

import Foundation

public func print(_ items: String..., filename: String = #file, function : String = #function, line: Int = #line, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let pretty = "\(URL(fileURLWithPath: filename).lastPathComponent) [#\(line)] \(function)\n\t-> "
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(pretty+output, terminator: terminator)
    #else
        Swift.print("RELEASE MODE")
    #endif
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    #else
        Swift.print("RELEASE MODE")
    #endif
}

