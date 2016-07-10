//
//  SearchViewController.swift
//  udacityProject
//
//  Created by Ryan Ballenger on 7/8/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UITextFieldDelegate{
    
    
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func doSearch(sender: AnyObject) {
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray)
        activity.center = self.view.center
        activity.startAnimating()
        self.view.addSubview(activity)
        
        
        let ytData = YoutubeData()
        
        ytData.requestData(searchText.text!, sender: self){() -> Void in
            self.performSegueWithIdentifier("resultsSegue", sender: sender)
            
            let subs = self.view.subviews
            
            for sub in subs{
                if(sub == activity){
                    sub.removeFromSuperview()
                }
            }
            
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

