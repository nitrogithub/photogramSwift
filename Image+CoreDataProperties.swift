//
//  Image+CoreDataProperties.swift
//  PhotogramSwift
//
//  Created by Atousa Duprat on 4/13/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Image {

    @NSManaged var comment: String?
    @NSManaged var image: NSData?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var timeStamp: NSDate?
    @NSManaged var user: User?
    @NSManaged var userComment: NSOrderedSet?

}
