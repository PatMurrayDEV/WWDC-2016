//
//  PMResponseTableViewCell.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 16/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PMResponseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var responseLabel: PMBubbleLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
