//
//  SettingsViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 29/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clearChatButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func seeAllMessagesButtonTapped(sender: AnyObject) {
        
    }

    @IBAction func seeJsonButtonTapped(sender: AnyObject) {
        
    }

    @IBAction func twitterButtonTapped(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "https://twitter.com/_patmurray")!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func githubButtonTapped(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "https://github.com/PatMurrayDEV")!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    
    @IBAction func websiteButtonTapped(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "http://patmurray.co")!)
        self.presentViewController(svc, animated: true, completion: nil)
    }
    

}
