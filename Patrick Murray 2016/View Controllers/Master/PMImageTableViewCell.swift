//
//  PMImageTableViewCell.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 25/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PMImageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var heightContrainst: NSLayoutConstraint!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentImage.layer.cornerRadius = 20.0
        contentImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
