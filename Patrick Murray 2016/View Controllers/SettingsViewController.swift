//
//  SettingsViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 29/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import SafariServices
import QuickLook


class SettingsViewController: UIViewController, QLPreviewControllerDataSource, QLPreviewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clearChatButtonTapped(sender: AnyObject) {
        let messagesManager = MessagesManager.sharedInstance
        let response = Response(json: ["next":100, "text":"Can we start again please?", "title":"Start Again?"])
        messagesManager.responseSelected(response!);
    }
    
    @IBAction func seeAllMessagesButtonTapped(sender: AnyObject) {
//        mainMessages
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("mainMessages") as! MasterViewController
        
        var objects : [ChatMessage] = [ChatMessage]()
        
        for section in MessagesManager.sharedInstance.getAll() {
            for message in section.messages! {
                objects.append(message)
            }
            for response in section.responses! {
                objects.append(response)
            }
        }
        
        vc.objects = objects
        
        self.navigationController?.pushViewController(vc, animated: true)
        

        
    }

    @IBAction func seeJsonButtonTapped(sender: AnyObject) {
        let licenseView : QLPreviewController = QLPreviewController()
        licenseView.delegate = self
        licenseView.dataSource = self
        self.presentViewController(licenseView, animated:true, completion:nil)
        self.previewController(licenseView, previewItemAtIndex: 0)
        
    }
    
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("content", ofType: "json")
        let url : NSURL = NSURL(fileURLWithPath: path!)
        return url
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
