//
//  StockEntry+CoreDataProperties.swift
//  StockBox
//
//  Created by Michael Manisa on 8/31/16.
//  Copyright © 2016 Michael Manisa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension StockEntry {

    @NSManaged var clientName: String?
    @NSManaged var imageReference: String?
    @NSManaged var projectNumber: String?
    @NSManaged var stockNumber: String?
    @NSManaged var website: String?

}
