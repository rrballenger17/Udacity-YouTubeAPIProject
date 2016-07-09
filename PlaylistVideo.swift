//
//  PlaylistVideo.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation
import CoreData


class PlaylistVideo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    convenience init(text: String = "New Video", title: String, videoId: String, details: String, context : NSManagedObjectContext){
        
        if let ent = NSEntityDescription.entityForName("PlaylistVideo", inManagedObjectContext: context){
            
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            
            self.title = title
            self.videoId = videoId
            self.details = details
            
        }else{
            fatalError("Unable to find Entity name!")
        }
        
    }

}
