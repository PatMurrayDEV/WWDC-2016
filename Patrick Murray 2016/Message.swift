//
//  Message.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 24/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit
import MapKit

struct MessageSection: Decodable {
    
    let id: Int?
    let messages: [Message]?
    let responses : [Response]?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.messages = "messages" <~~ json
        self.responses = "responses" <~~ json
    }

}




protocol ChatMessage: Decodable {
    var text: String? { get set }
}

struct Response: ChatMessage, Decodable {
    let next: Int?
    var text: String?
    let title: String?
    init?(json: JSON) {
        self.next = "next" <~~ json
        self.title = "title" <~~ json
        self.text = "text" <~~ json
    }
}

struct Message: ChatMessage, Decodable {
    var text: String?
    var image: UIImage?
    var helpText: String?
    var mapLoc: CLLocationCoordinate2D?
    var pitch: CGFloat?
    var heading: Double?
    var distance: Double?
    
    init?(json: JSON) {
        
        if let textContent : String = "text" <~~ json {
            self.text = textContent
        }
        
        if let helpContent : String = "help_text" <~~ json {
            self.helpText = helpContent
        }
        
        if let imageURL : String = "image_url" <~~ json {
            if let imageTemp : UIImage = UIImage(named: imageURL) {
                self.image = imageTemp
            }
        }
        
        if let long : Double = "longitude" <~~ json {
            if let lat : Double = "latitude" <~~ json {
                self.mapLoc = CLLocationCoordinate2DMake(lat, long)
            }
        }
        
        if let pitchContent : CGFloat = "pitch" <~~ json {
            self.pitch = pitchContent
        }
        
        if let headingContent : Double = "heading" <~~ json {
            self.heading = headingContent
        }
        
        if let distance : Double = "distance" <~~ json {
            self.distance = distance
        }
        
    }
}





