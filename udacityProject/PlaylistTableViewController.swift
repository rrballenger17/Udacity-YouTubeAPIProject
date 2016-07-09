//
//  PlaylistTableViewController.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation
import CoreData

import UIKit

class PlaylistTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{
    
    
    var videos: [PlaylistVideo]!
    
    let stack = (UIApplication.sharedApplication().delegate as! AppDelegate).stack

    var fetchedResultsController : NSFetchedResultsController?{
        didSet{
            fetchedResultsController?.delegate = self
            doSearch()
        }
    }
    
    
    func getSavedVideos(){
        
        let fr = NSFetchRequest(entityName: "PlaylistVideo")
        fr.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        videos = fetchedResultsController?.fetchedObjects as! [PlaylistVideo]
        
    }
    
    
    
    let cellReuseIdentifier = "MyCellReuseIdentifier"
    
    // Add the two essential table data source methods here
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(videos == nil){
            getSavedVideos()
        }
        
        return videos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(videos == nil){
            getSavedVideos()
        }
        
        let cell =  tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier)! as UITableViewCell
        
        let info = videos[indexPath.row]
        
        cell.textLabel?.text = info.title
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        if(!removeIt){
            (UIApplication.sharedApplication().delegate as! AppDelegate).videoId = videos[indexPath.row].videoId!
            
            
            (UIApplication.sharedApplication().delegate as! AppDelegate).structs = []
            
            for v in videos{
                var newStruct = videoInfo()
                newStruct.title = v.title
                newStruct.description = v.details
                newStruct.videoId = v.videoId
                (UIApplication.sharedApplication().delegate as! AppDelegate).structs.append(newStruct)
            }
            
            
            
            let view = storyboard!.instantiateViewControllerWithIdentifier("PlayView") as! ViewController
            
            navigationController?.pushViewController(view, animated: true)
            
            return
        }
        
        
        let video:PlaylistVideo = videos[indexPath.row]
        
        stack.context.deleteObject(video)
        
        saveContext()
        
        videos = nil
        
        self.tableView.reloadData()
        
    }
    
    func saveContext(){
        
        do{
            try stack.saveContext()
        }catch{
            print("Error while saving.")
        }
    }
  
    
    var removeIt:Bool = false
    
    func removeMode(){
        
        if(removeIt){
            removeIt = false
            
            navigationItem.rightBarButtonItem!.title = "Edit"
            
            navigationItem.rightBarButtonItem!.tintColor = nil
            
        }else{
            
            removeIt = true
        
            navigationItem.rightBarButtonItem!.title = "Done"
            
            navigationItem.rightBarButtonItem!.tintColor = UIColor.redColor()
            
        }
        
        print("remove function")
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Playlist"
        
        var button = UIBarButtonItem()
        
        button.title = "Edit"
    
        button.target = self
        
        button.action = #selector(removeMode)
        
        navigationItem.rightBarButtonItem = button
        
        print("viewDidLoad")
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

    }
    
    
}


extension PlaylistTableViewController{
    
    func doSearch(){
        if let fc = fetchedResultsController{
            do{
                try fc.performFetch()
            }catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
        }
    }
}

