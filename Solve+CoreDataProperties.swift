//
//  Solve+CoreDataProperties.swift
//  Scrambler
//
//  Created by Isaac Lyons on 7/15/20.
//  Copyright © 2020 Blizzard Skeleton. All rights reserved.
//
//

import Foundation
import CoreData


extension Solve {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Solve> {
        return NSFetchRequest<Solve>(entityName: "Solve")
    }

    @NSManaged public var moves: String?
    @NSManaged public var time: Float
    @NSManaged public var date: Date?

}
