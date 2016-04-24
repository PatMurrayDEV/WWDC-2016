//
//  Message.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 24/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit

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
    init?(json: JSON) {
        self.text = "text" <~~ json
    }
}



