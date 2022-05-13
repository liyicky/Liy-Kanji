//
//  NewCardIndex+CoreDataProperties.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/05/13.
//
//

import Foundation
import CoreData


extension NewCardIndex {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewCardIndex> {
        return NSFetchRequest<NewCardIndex>(entityName: "NewCardIndex")
    }

    @NSManaged public var index: Int16

}

extension NewCardIndex : Identifiable {

}
