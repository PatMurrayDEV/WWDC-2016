//
//  PMResponsesTableViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 16/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PMResponsesTableViewController: UITableViewController {
    
    var array : [Response] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
        
        self.tableView.scrollEnabled = false;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("responseCell", forIndexPath: indexPath) as! PMResponseTableViewCell
        
        let object = array[indexPath.row]
        
        cell.responseLabel.text = object.title
        
//        scrollToBottom()
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRectZero)
//        headerView.userInteractionEnabled = false
//        return headerView
//    }
//    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return self.tableView.frame.size.height - self.tableView.contentSize.height
//    }
//    
//    func scrollToBottom() {
//        let offsetY = self.tableView.contentSize.height - self.tableView.frame.size.height + self.tableView.contentInset.bottom;
//        self.tableView.setContentOffset(CGPointMake(0, offsetY), animated: true)
//    }


}
