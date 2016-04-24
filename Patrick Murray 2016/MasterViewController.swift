//
//  MasterViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 15/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, chatViewer {

    var detailViewController: DetailViewController? = nil
    var objects = [ChatMessage]()
    var responses = [Response]()
    
    var footer : UIView = UIView()
    
    // MARL: - ChatViewer
    
    func newMessage(msg: Message) {
        objects.append(msg)
        let indexPathOfLastRow = NSIndexPath(forRow: objects.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPathOfLastRow], withRowAnimation: .Fade)
        self.tableView.scrollToRowAtIndexPath(indexPathOfLastRow, atScrollPosition: .Bottom, animated: true)
    }
    
    func newResponse(responses: [Response]) -> Response {
        objects.append(responses.first!)
        let indexPathOfLastRow = NSIndexPath(forRow: objects.count - 1, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPathOfLastRow], withRowAnimation: .Fade)
        self.tableView.scrollToRowAtIndexPath(indexPathOfLastRow, atScrollPosition: .Bottom, animated: true)
        
        self.responses = responses
        self.tableView.reloadData()
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let pvc = storyboard.instantiateViewControllerWithIdentifier("responseVC") as! PMResponsesTableViewController
//        pvc.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
//        pvc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        
//        pvc.array = responses
//        
//        let footer = UIView(frame: CGRect(x: 0, y: 0, width: pvc.tableView.frame.width, height: pvc.tableView.contentSize.height))
//        
//        self.tableView.tableFooterView = footer
//        self.tableView.tableFooterView?.userInteractionEnabled = true
//        self.tableView.tableFooterView?.frame = footer.frame
//        
//        UIView.animateWithDuration(0.33) { 
//            footer.addSubview(pvc.tableView)
//        }
//        
//        footer.userInteractionEnabled = true
//        
//        footer.backgroundColor = .greenColor()

//
//        self.presentViewController(pvc, animated: true, completion: nil)
        
        
        return responses.first!
    }
    

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = storyboard.instantiateViewControllerWithIdentifier("responseVC") as! PMResponsesTableViewController
        
        pvc.array = responses
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: pvc.tableView.frame.width, height: pvc.tableView.contentSize.height))
        
        self.footer = footerView

        return self.footer
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }


    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0
        
        let inset = UIEdgeInsetsMake(20, 0, 40, 0);
        tableView.contentInset = inset;
        
        let messages = MessagesManager()
        messages.delegate = self
        messages.loadMessages()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
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
        
        var cell : PMChatTableViewCell
        if object is Message {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PMChatTableViewCell
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! PMChatTableViewCell
        }

        cell.messageLabel!.text = object.text
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

