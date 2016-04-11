//
//  User+CoreDataProperties.swift
//  PhotogramSwift
//
//  Created by Atousa Duprat on 4/11/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var gender: String?
    @NSManaged var profileName: String?
    @NSManaged var realName: String?
    @NSManaged var comments: NSSet?
    @NSManaged var image: NSSet?

}
