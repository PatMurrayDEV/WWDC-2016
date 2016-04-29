//
//  PMMapTableViewCell.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 25/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import MapKit
import AudioToolbox

class PMMapTableViewCell: UITableViewCell {
    
    private let maxForceValue: CGFloat = 6.6 - 1
    
    var mapView: MKMapView?
    @IBOutlet weak var imagePlaceholder: UIImageView!

    
    var mapLoc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(-33.852222, 151.210556)
    var pitch : CGFloat = 45.0
    var heading = 90.0
    var distance: CLLocationDistance = 750
    
    var animated = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        let gesture = ForceGestureRecognizer()
        gesture.addTarget(self, action: #selector(PMMapTableViewCell.backgroundPressed(_:)))
        self.addGestureRecognizer(gesture)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PMMapTableViewCell.handleTap(_:)))
        gestureRecognizer.numberOfTouchesRequired = 2
        self.addGestureRecognizer(gestureRecognizer)
        
        self.layoutIfNeeded()
        
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        let image = UIImage(view: self.mapView!)


        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    internal func destroyMap() {
        
        if mapView != nil {
            self.mapView!.delegate = nil
            self.mapView?.removeFromSuperview()
            self.mapView!.mapType = MKMapType.Standard
            self.mapView!.showsUserLocation = false
            self.mapView!.delegate = nil
            self.mapView!.removeFromSuperview()
            self.mapView = nil
        }
        
    }
    
    
    func backgroundPressed(sender: ForceGestureRecognizer) {
        
        
        
        if sender.state == .Ended {
            self.imagePlaceholder.hidden = false
            UIView.animateWithDuration(0.1, animations: {
                self.imagePlaceholder.alpha = 1.0
                }, completion: { finished in
                    self.destroyMap()
            })
            return
        }
        
        
        if sender.forceValue > 1 {
            if mapView == nil {
                setUpMap()
//                AudioServicesPlaySystemSound(1/5/2/0)
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            } else {
                let force = sender.forceValue - 1
                let camera = MKMapCamera(lookingAtCenterCoordinate: self.mapLoc,
                                         fromDistance: (self.distance + Double(100 * force/maxForceValue)),
                                         pitch: (self.pitch + (10 * force/maxForceValue)),
                                         heading: (self.heading + Double(360 * force/maxForceValue)))
                self.mapView!.camera = camera
            }
            
        }
        
        

   
    }
    
    
    func setUpMap() {
        
        mapView = MKMapView()
        mapView?.frame = imagePlaceholder.frame
        mapView?.layer.cornerRadius = 20.0
        mapView?.clipsToBounds = true
        mapView?.showsCompass = false;
        mapView!.mapType = .SatelliteFlyover
        
        mapView?.showsBuildings = true


        let cameraInitial = MKMapCamera(lookingAtCenterCoordinate: self.mapLoc, fromDistance: self.distance, pitch: self.pitch, heading: self.heading)
        mapView?.camera = cameraInitial
        
        
        UIView.animateWithDuration(0.33, animations: { 
            self.addSubview(self.mapView!)
            self.imagePlaceholder.alpha = 0.0
            }, completion: { finished in
                self.imagePlaceholder.hidden = true
        })
        
        
        
    }
    
    
    
    func loadMap(coordinates: CLLocationCoordinate2D, pitch: CGFloat?, heading: Double?, showLandmarks: Bool, distance: Double?, placeholder: UIImage) {
        
//        if showLandmarks {
//            mapView.mapType = .HybridFlyover
//        } else {
//            mapView.mapType = .SatelliteFlyover
//        }
//        
//        
        self.mapLoc = coordinates
        self.pitch = pitch!
        self.heading = heading!
        self.distance = distance!
//
//        mapView.showsBuildings = true
//        
//        
//        let cameraInitial = MKMapCamera(lookingAtCenterCoordinate: coordinates, fromDistance: distance!, pitch: pitch!, heading: heading!)
//        mapView.camera = cameraInitial
        
        
        self.imagePlaceholder.image = placeholder
        
        
        
        
    }

}
