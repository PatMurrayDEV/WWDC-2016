//
//  PMContainerViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 24/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PMContainerViewController: UIViewController, chatViewer, ResponseProtocol {
    
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var responseHeightConstraint: NSLayoutConstraint!
    
    var mastVC : MasterViewController = MasterViewController()
    var respVC : PMResponsesTableViewController = PMResponsesTableViewController()
    
    let messagesManager = MessagesManager.sharedInstance


    override func viewDidLoad() {
        super.viewDidLoad()
        
        for vc in self.childViewControllers {
            if vc is MasterViewController {
                mastVC = vc as! MasterViewController
            } else if vc is PMResponsesTableViewController {
                respVC = vc as! PMResponsesTableViewController
                respVC.delegate = self
            }
        }
        
        print(mastVC)
        print(respVC)
        
        self.title = "Pat Murray"
        

        
        self.messagesManager.delegate = self
        self.messagesManager.loadMessages()
        
        checkConstraints()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ChatViewer
    
    func newMessage(msg: ChatMessage) {
        mastVC.newMessage(msg)
    }
    
    func newResponse(responses: [Response]) {
        
        respVC.array = responses
        respVC.tableView.reloadData()
        respVC.tableView.setNeedsDisplay()
        checkConstraints()
        
    }
    
    func checkConstraints() {
        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.responseHeightConstraint.constant = self.respVC.tableView.contentSize.height
            UIView.animateWithDuration(0.5) {
                self.view.layoutIfNeeded()
                //self.mastVC.tableView.layoutIfNeeded()
            }
            let indexPathOfLastRow = NSIndexPath(forRow: self.mastVC.objects.count - 1, inSection: 0)
            if indexPathOfLastRow.row > 0 {
                self.mastVC.tableView.scrollToRowAtIndexPath(indexPathOfLastRow, atScrollPosition: .Bottom, animated: true)
            }
            
        }
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - ResponseProtocol
    
    func responseSelected(selected: Response) {
        self.messagesManager.responseSelected(selected)
        respVC.array = []
        respVC.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Bottom)
        respVC.tableView.reloadData()
        respVC.tableView.setNeedsDisplay()
        checkConstraints()
        //mastVC.tableView.reloadData()
        //mastVC.tableView.setNeedsDisplay()
        
        
    }
    
    func clearScreen() {
        
        self.mastVC.clearScreen()

    }

    
}
