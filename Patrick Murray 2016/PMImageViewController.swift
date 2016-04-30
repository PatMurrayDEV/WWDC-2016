//
//  PMImageViewController.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 30/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

class PMImageViewController: UIViewController {
    

    
    @IBOutlet weak var containerView: UIView!
    var motionView: PanoramaView!
    
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionView = PanoramaView(frame: self.view.bounds)
        motionView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(motionView)
        
        let views = ["view": containerView, "newView": motionView]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[newView]-0-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views)
        containerView.addConstraints(horizontalConstraints)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[newView]-100-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views)
        containerView.addConstraints(verticalConstraints)


       
        
        containerView.layer.cornerRadius = 10.0
        containerView.clipsToBounds = true
        
        
        motionView.setImage(image!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }


    

}
