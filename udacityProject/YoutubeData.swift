//
//  YoutubeData.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//


import UIKit


class YoutubeData {
    
    
    let stack = (UIApplication.sharedApplication().delegate as! AppDelegate).stack
    
    var structs: [videoInfo] = []
    
    func requestData(param: String, sender: SearchViewController, completionHandler: () -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        var urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=10&key=AIzaSyAA-MIYnX5mFkmcVjXcy8VIeN6ZQ47zk_s&q=" + param
        
        urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func dataError(error: String) {
                print(error)
                
                let alert = UIAlertController(title: "Data Error", message: "The server returned unrecognized data.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.performUIUpdatesOnMain(){
                    sender.presentViewController(alert, animated: true, completion: nil)
                }
                
                sender.viewDidAppear(false)
            }
            
            func connectionError(error: String){
                print(error)
                
                let alert = UIAlertController(title: "Connection Error", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.performUIUpdatesOnMain(){
                    sender.presentViewController(alert, animated: true, completion: nil)
                }
                
                sender.viewDidAppear(false)

            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                connectionError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                connectionError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                connectionError("No data was returned by the request!")
                return
            }
            
            // parse the data
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                dataError("Could not parse the data as JSON: '\(data)'")
                return
            }
        
            /* GUARD: Did Flickr return an error (stat != ok)? */
            guard let items = parsedResult["items"] as? [[String:AnyObject]] else {
                print("items error")
                return
            }
            
            //print(items)
            
            
            
            for item in items {
                
                guard let id = item["id"] as? [String:AnyObject] else {
                    print("id error")
                    
                    return
                }
                
                guard let videoId = id["videoId"] as? String else {
                    print("videoId error")
                    return
                }

                guard let snippet = item["snippet"] as? [String:AnyObject] else {
                    print("snippet error")
                    return
                }
                
                guard let title = snippet["title"] as? String else {
                    print("title error")
                    return
                }
                
                guard let description = snippet["description"] as? String else {
                    print("description error")
                    return
                }
                
                var info = videoInfo()
                info.videoId = videoId
                info.title = title
                info.description = description
                
                
                //PlaylistVideo(title: title, videoId: videoId, details: description, context: self.stack.context)
                

                self.structs.append(info)
                
                
            }
            
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.structs = self.structs
            
            self.performUIUpdatesOnMain(){
                completionHandler()
            }
            
        
        }
        
        // start the task!
        task.resume()
    }
    

    
    
    func performUIUpdatesOnMain(updates: () -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            updates()
        }
    }
    
    
}
