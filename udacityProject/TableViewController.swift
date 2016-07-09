//
//  TableViewController.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation

import UIKit

class TableViewController: UITableViewController{
        
    var structs: [videoInfo] = (UIApplication.sharedApplication().delegate as! AppDelegate).structs

    var results: [String] = ["hey", "dude", "what's", "up"]
    
    
    let cellReuseIdentifier = "MyCellReuseIdentifier"
    
    // Add the two essential table data source methods here
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return structs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier)! as UITableViewCell
        
        let info = structs[indexPath.row]
        
        cell.textLabel?.text = info.title
                
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).videoId = structs[indexPath.row].videoId
        
        
        let view = storyboard!.instantiateViewControllerWithIdentifier("PlayView") as! ViewController
        
        navigationController?.pushViewController(view, animated: true)
        
    }
    

    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
    }
    
    
}




