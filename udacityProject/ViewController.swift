//
//  ViewController.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/7/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit



class ViewController: UIViewController, YTPlayerViewDelegate{
    
    
    let stack = (UIApplication.sharedApplication().delegate as! AppDelegate).stack
    
    var videoID: String = (UIApplication.sharedApplication().delegate as! AppDelegate).videoId
    
    var structs = (UIApplication.sharedApplication().delegate as! AppDelegate).structs
    

    @IBAction func addToPlaylist(sender: AnyObject) {
        
        for s in structs{
            if s.videoId == videoID{
                PlaylistVideo(title: s.title, videoId: s.videoId, details: s.description, context: stack.context)
            }
        }
        
        saveContext()
    }
    
  
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UITextView!
    
    func saveContext(){
        
        do{
            try stack.saveContext()
        }catch{
            print("Error while saving.")
        }
    }
    
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        // Do any additional setup after loading the view.
        print(videoID)
        
        
        for s in structs{
            if s.videoId == videoID {
                titleLabel.text = s.title
                descrLabel.text = s.description
            }
        }

        playerView.loadWithVideoId(videoID)
        
        self.automaticallyAdjustsScrollViewInsets = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

