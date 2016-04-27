//
//  MasterViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 15/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
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
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = object.text
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
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
                cell.loadMap(message.mapLoc!, pitch: message.pitch!, heading: message.heading!, showLandmarks: false, distance: message.distance!)
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

    
//    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if cell is PMMapTableViewCell {
//            let mapCell = cell as! PMMapTableViewCell
//            mapCell.applyMapMemoryFix()
//        }
//    }


}

