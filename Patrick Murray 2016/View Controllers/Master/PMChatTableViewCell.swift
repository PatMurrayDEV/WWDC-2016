//
//  PMChatTableViewCell.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 15/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import QuartzCore

class PMChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: PMBubbleLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
