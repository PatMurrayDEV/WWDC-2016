//
//  MessagesManager.swift
//  Patrick Murray 2016
//
//  Created by Patrick Murray on 24/04/2016.
//  Copyright © 2016 Patrick Murray. All rights reserved.
//

import UIKit


protocol chatViewer {
    
    func newMessage(text: ChatMessage)
    func newResponse(responses: [Response])
    func clearScreen()
    
}

class MessagesManager: NSObject {
    
    var messages : [MessageSection] = []
    var delegate:chatViewer! = nil
    var seenArray: [Int] = [Int]()
    
    static let sharedInstance = MessagesManager()
    
    
    func loadMessages()  {
        if let path = NSBundle.mainBundle().pathForResource("content", ofType: "json") {
            if let jsonData = NSData(contentsOfFile:path) {
                do {
                    let object = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                    messages = [MessageSection].fromJSONArray(object as! [JSON])
//                    print(messages)
                    displaySection(messages.first!)
                } catch {
                    // Handle Error
                }
            }
        }
    }
    
    
    func displaySection(section: MessageSection) {
        
        
//        let def = NSUserDefaults.standardUserDefaults()
//        let key = "viewed"
//        
//        //read
//        if let testArray : AnyObject? = def.objectForKey(key) {
//            var readArray : [Int] = testArray! as! [Int]
//            
//            readArray.append(section.id!)
//            def.setObject(readArray, forKey: key)
//            def.synchronize()
//            
//        } else {
//            
//            
//            array1.append(section.id!)
//            def.setObject(array1, forKey: key)
//            def.synchronize()
//            
//        }
        
        
        seenArray.append(section.id!)

        
        var count = 1.5
        
        for text in section.messages! {
            
            if text.helpText != nil {
                count = count - 1.2
                
                let delay = 1.0 * count * Double(NSEC_PER_SEC)
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.delegate.newMessage(text)
                }
                
            } else {
                //            let delay = 0.5 * count * Double(NSEC_PER_SEC)
                let delay = 0.9 * count * Double(NSEC_PER_SEC)
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.delegate.newMessage(text)
                }
            }
            

            count = count + 1.5
        }
        
        if let responses = section.responses {
            
            
            
            var responsesFiltered : [Response] = [Response]()
            
            for response in responses {
                
                if (!seenArray.contains(response.next!)) {
                    responsesFiltered.append(response)
                }
                
            }
            
            if responsesFiltered.count == 0 {
                
                let delay = 0.9 * count * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.delegate.newMessage(Message(json: ["help_text":"You've reached the end of the content (or somehow a dead end), there is plenty more to explore. You can restart and try and take a different route if you want. Hope you enjoyed it. "])!)
                }
                count = count + 1.5
                
                let response = Response(json: ["next":100, "text":"Can we start again please?", "title":"Start Again?"])
                responsesFiltered.append(response!)
                
                seenArray.removeAll()
                
            }
            
            let delay = (count - 1) * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(time, dispatch_get_main_queue()) {
                self.delegate.newResponse(responsesFiltered)
            }
        }
    }
    
    func responseSelected(selected: Response) {
        
        if selected.next == 100 {
            self.delegate.clearScreen()
            print(selected.title)
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.nextSection(selected.next!)
            }
        } else {
            print(selected.title)
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.delegate.newMessage(selected)
                self.nextSection(selected.next!)
            }
        }
        
    }
    
    func getAll() -> [MessageSection] {
        return messages
    }
    
    func nextSection(sectionID: Int) {
        let result = self.messages.filter() {
            message in
            return message.id == sectionID
        }
        displaySection(result.first!)
    }

}
