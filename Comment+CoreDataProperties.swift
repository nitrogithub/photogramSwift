//
//  Comment+CoreDataProperties.swift
//  PhotogramSwift
//
//  Created by Atousa Duprat on 4/12/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Comment {

    @NSManaged var comment: String?
    @NSManaged var isLike: NSNumber?
    @NSManaged var image: Image?
    @NSManaged var user: User?

}
