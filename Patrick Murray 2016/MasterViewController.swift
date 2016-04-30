//
//  MasterViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 15/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import SafariServices


class MasterViewController: UITableViewController {

    var objects = [ChatMessage]()

    
    var footer : UIView = UIView()
    
    // MARL: - ChatViewer
    
    func newMessage(msg: ChatMessage) {

        objects.append(msg)
        let indexPathOfLastRow = NSIndexPath(forRow: objects.count - 1, inSection: 0)
        
        var animation : UITableViewRowAnimation
        if msg is Message {
            let message = msg as! Message
            if message.helpText != nil {
                animation = .Fade
            } else {
                animation = .Left
            }
        } else {
            animation = .Right
        }

        // Transaction
        CATransaction.begin()
        tableView.beginUpdates()
        CATransaction.setCompletionBlock { () -> Void in
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0) - 1, inSection: 0), atScrollPosition: .Middle, animated: true)
        }
        self.tableView.insertRowsAtIndexPaths([indexPathOfLastRow], withRowAnimation: animation)
        tableView.endUpdates()
        CATransaction.commit()

    }
    
    func clearScreen() {
        
        objects.removeAll()
        self.tableView.reloadData()
        
    }

    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160
        
        let inset = UIEdgeInsetsMake(20, 0, 40, 0);
        tableView.contentInset = inset;
        

        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIView.setAnimationBeginsFromCurrentState(true)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

    }
    


    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let object = objects[indexPath.row]

        if object is Message {
            let message = object as! Message
            if let text = message.text {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PMChatTableViewCell
                cell.messageLabel!.text = text
                return cell
            } else if let image = message.image {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell_Image", forIndexPath: indexPath) as! PMImageTableViewCell
                cell.contentImage.image = image
                if let height = cell.contentImage.image?.size.height {
                    if height < 200 {
                        cell.heightContrainst.constant = height
                    } else {
                        cell.heightContrainst.constant = 200
                    }
                }
                return cell
            } else if let help = message.helpText {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell_Help", forIndexPath: indexPath)
                cell.textLabel?.text = help
                return cell
            } else if message.mapLoc != nil {
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell_Map", forIndexPath: indexPath) as! PMMapTableViewCell
                cell.loadMap(message.mapLoc!, pitch: message.pitch!, heading: message.heading!, showLandmarks: false, distance: message.distance!, placeholder: message.placeholderImage!)
                return cell
            } else if message.linkURL != nil {
                let cell = tableView.dequeueReusableCellWithIdentifier("link_cell", forIndexPath: indexPath) as! PMChatTableViewCell
                cell.messageLabel!.text = message.linkURL
                return cell
            } else if let livePhoto = message.livePhoto  {
                
                let image = UIImage(imageLiteral: livePhoto)
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell_Live", forIndexPath: indexPath) as! PMLivePhotoTableViewCell
                
                if image.size.height < 200 {
                    cell.heightContrainst.constant = image.size.height
                } else {
                    cell.heightContrainst.constant = 200
                }
                
                cell.placeholderImage = image
                cell.imageURL = NSBundle.mainBundle().URLForResource(livePhoto, withExtension: "JPG")!
                cell.videoURL = NSBundle.mainBundle().URLForResource(livePhoto, withExtension: "MOV")!
                
                cell.prepareLivePhoto()
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! PMChatTableViewCell
            cell.messageLabel!.text = object.text
            return cell
        }
        
        
        // Else
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! PMChatTableViewCell
        cell.messageLabel!.text = object.text
        return cell

    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object = objects[indexPath.row]
        
        if object is Message {
            let message = object as! Message
            if message.linkURL != nil {
                let svc = SFSafariViewController(URL: NSURL(string: message.linkURL!)!)
                self.presentViewController(svc, animated: true, completion: nil)
            } else if let image = message.image {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("imagePanorama") as! PMImageViewController
                vc.image = image
                self.presentViewController(vc, animated: true, completion: nil)
                
            }

            
        }
        
    }





}







