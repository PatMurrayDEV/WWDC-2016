//
//  PMBubbleLabel.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 15/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

@IBDesignable
class PMBubbleLabel: UILabel {

    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, padding))
    }
    
    // Override -intrinsicContentSize: for Auto layout code
    override func intrinsicContentSize() -> CGSize {
        let superContentSize = super.intrinsicContentSize()
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    // Override -sizeThatFits: for Springs & Struts code
    override func sizeThatFits(size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var bgColor: UIColor {
        get {
            return UIColor(CGColor: self.layer.backgroundColor!)
        }
        set {
            self.layer.backgroundColor = newValue.CGColor
        }
    }
    
    @IBInspectable var color: UIColor {
        get {
            return self.textColor
        }
        set {
            self.textColor = newValue
        }
    }

}





@IBDesignable
class PMButton: UIButton {
    
    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    // Override -intrinsicContentSize: for Auto layout code
    override func intrinsicContentSize() -> CGSize {
        let superContentSize = super.intrinsicContentSize()
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    // Override -sizeThatFits: for Springs & Struts code
    override func sizeThatFits(size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var bgColor: UIColor {
        get {
            return UIColor(CGColor: self.layer.backgroundColor!)
        }
        set {
            self.layer.backgroundColor = newValue.CGColor
        }
    }
    
    @IBInspectable var color: UIColor {
        get {
            return self.currentTitleColor
        }
        set {
            self.setTitleColor(newValue, forState: UIControlState.Normal)
        }
    }
    
}







