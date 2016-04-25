//
//  PMResponsesTableViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 16/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

protocol ResponseProtocol {
    func responseSelected(selected: Response)
}

class PMResponsesTableViewController: UITableViewController {
    
    var array : [Response] = []
    var delegate : ResponseProtocol! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60.0
        
        self.tableView.scrollEnabled = false;
        self.tableView.backgroundColor = .greenColor()
        

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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        
        let response = self.array[indexPath.row]
        if let delegate = self.delegate {
            delegate.responseSelected(response)
        }
        
    }


}
