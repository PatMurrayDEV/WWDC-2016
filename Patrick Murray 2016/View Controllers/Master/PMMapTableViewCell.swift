//
//  PMMapTableViewCell.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 25/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import MapKit

class PMMapTableViewCell: UITableViewCell {
    
    private let maxForceValue: CGFloat = 6.6
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imagePlaceholder: UIImageView!

    
    var mapLoc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(-33.852222, 151.210556)
    var pitch : CGFloat = 45.0
    var heading = 90.0
    var distance: CLLocationDistance = 750
    
    var animated = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mapView.layer.cornerRadius = 20.0
        mapView.clipsToBounds = true
        mapView.showsCompass = false;
        
        
        let gesture = ForceGestureRecognizer()
        gesture.addTarget(self, action: #selector(PMMapTableViewCell.backgroundPressed(_:)))
        self.mapView.addGestureRecognizer(gesture)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PMMapTableViewCell.handleTap(_:)))
        gestureRecognizer.numberOfTouchesRequired = 2
        self.addGestureRecognizer(gestureRecognizer)
        
        self.layoutIfNeeded()
        
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        let image = UIImage(view: self.mapView)
        
//        if let data = UIImagePNGRepresentation(image) {
//            let filename = getDocumentsDirectory().stringByAppendingPathComponent("map_\(self.mapLoc.latitude)_\(self.mapLoc.longitude).png")
//            data.writeToFile(filename, atomically: true)
//            print(filename)
//        }

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
    
    
    internal func applyMapMemoryFix() {
        
        self.mapView.delegate = nil
        
    }
    
    
    func backgroundPressed(sender: ForceGestureRecognizer) {
        
        if sender.state == .Ended {
            UIView.animateWithDuration(0.1, animations: {
                let camera = MKMapCamera(lookingAtCenterCoordinate: self.mapLoc, fromDistance: self.distance, pitch: self.pitch, heading: self.heading)
                self.mapView.camera = camera
            })
            return
        }
        
        
        let camera = MKMapCamera(lookingAtCenterCoordinate: self.mapLoc,
                                 fromDistance: (self.distance + Double(100 * sender.forceValue/maxForceValue)),
                                 pitch: (self.pitch + (10 * sender.forceValue/maxForceValue)),
                                    heading: (self.heading + Double(360 * sender.forceValue/maxForceValue)))
        self.mapView.camera = camera
   
    }
    
    
    
    
    func loadMap(coordinates: CLLocationCoordinate2D, pitch: CGFloat?, heading: Double?, showLandmarks: Bool, distance: Double?) {
        
        if showLandmarks {
            mapView.mapType = .HybridFlyover
        } else {
            mapView.mapType = .SatelliteFlyover
        }
        
        
        self.mapLoc = coordinates
        self.pitch = pitch!
        self.heading = heading!
        self.distance = distance!
    
        mapView.showsBuildings = true
        
        
        let cameraInitial = MKMapCamera(lookingAtCenterCoordinate: coordinates, fromDistance: distance!, pitch: pitch!, heading: heading!)
        mapView.camera = cameraInitial
        
        
        
        
    }

}
