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
        motionView.translatesAutoresizingMaskIntoConstraints = true
        self.containerView.addSubview(motionView)
        
        motionView.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        motionView.autoresizingMask = [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleRightMargin, UIViewAutoresizing.FlexibleTopMargin, UIViewAutoresizing.FlexibleBottomMargin]


        
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
