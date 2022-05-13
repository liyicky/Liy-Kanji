//
//  Card+CoreDataProperties.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/13.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var dateLastReviewed: Date?
    @NSManaged public var easinessFactor: Double
    @NSManaged public var id: Int16
    @NSManaged public var interval: Int32
    @NSManaged public var mnemonic: String?
    @NSManaged public var repCount: Int64
    @NSManaged public var successfulReps: Int64

}

extension Card : Identifiable {

}
