//
//  PlaylistVideo+CoreDataProperties.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PlaylistVideo {

    @NSManaged var title: String?
    @NSManaged var videoId: String?
    @NSManaged var details: String?

}
