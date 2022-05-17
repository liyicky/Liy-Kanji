//
//  CollectionExtensions.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/16.
//
//  Wendy Liga: https://wendyliga.medium.com/say-goodbye-to-index-out-of-range-swift-eca7c4c7b6ca

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
