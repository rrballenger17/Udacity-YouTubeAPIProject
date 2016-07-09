//
//  SearchViewController.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UITextFieldDelegate{
    
    var url = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&key=AIzaSyAA-MIYnX5mFkmcVjXcy8VIeN6ZQ47zk_s&q=xbox"
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func doSearch(sender: AnyObject) {
        
        label.text = "Searching..."
        
        
        let ytData = YoutubeData()
        
        ytData.requestData(searchText.text!, sender: self){() -> Void in
            self.performSegueWithIdentifier("resultsSegue", sender: sender)
            
            
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        label.text = "Youtube Video Search and Local Playlist"
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n"){
            textField.resignFirstResponder()
            
            doSearch(self)
            
            return false
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.clearsOnBeginEditing = true
        
        searchText.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

