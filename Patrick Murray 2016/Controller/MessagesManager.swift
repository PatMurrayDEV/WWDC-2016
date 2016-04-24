//
//  MessagesManager.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 24/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit


protocol chatViewer {
    
    func newMessage(text: Message)
    func newResponse(responses: [Response]) -> Response
    
}

class MessagesManager: NSObject {
    
    var messages : [MessageSection] = []
    var delegate:chatViewer! = nil
    
    func loadMessages()  {
        if let path = NSBundle.mainBundle().pathForResource("content", ofType: "json") {
            if let jsonData = NSData(contentsOfFile:path) {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                    messages = [MessageSection].fromJSONArray(object as! [JSON])
                    print(messages)
                    
                    
                    displaySection(messages.first!)
                    
                    
                } catch {
                    // Handle Error
                }
            }
        }
    }
    
    
    func displaySection(section: MessageSection) {
        
        var count = 0.0
        
        for text in section.messages! {
            let delay = 1 * count * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))

            dispatch_after(time, dispatch_get_main_queue()) {
                self.delegate.newMessage(text)
            }
            count = count + 1
        }
        
        
        
        if let responses = section.responses {
            let delay = 1 * count * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(time, dispatch_get_main_queue()) {
                self.delegate.newResponse(responses)
            }
        }
        
    }
 

}
