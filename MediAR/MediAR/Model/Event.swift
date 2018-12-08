//
//  Event.swift
//  MediAR
//
//  Created by bobdabuild on 11/30/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import Foundation
import SwiftyJSON

class Event {
    let title : String
    let imgurkey : String
    let desc : String
    let lat : Float
    let long : Float
    let preview : String
    var ratings : [String]?
    
    
    init(title: String, imagelink: String, desc: String, lat: Float, long: Float, preview: String, ratings: [String]?) {
        self.title = title
        self.imgurkey = imagelink
        self.desc = desc
        self.lat = lat
        self.long = long
        self.preview = preview
        self.ratings = ratings
    }
    
    // Take response from backend and populate an Event object
    static func getFromBackend(data: NSData) -> [Event] {
        var events : [Event] = []
        do {
            let swiftyjson = try JSON(data: data as Data)
            if let eventdata = swiftyjson["data"].array {
                for object in eventdata {
                    let eventName = object["media"].string!
                    let eventPreview = object["preview"].string!
                    let lat = object["lat"].float!
                    let long = object["long"].float!
                    let descrip = object["descrip"].string!
                    let img = object["imgurkey"].string!
                    
                    let event = Event(title: eventName, imagelink: img, desc: descrip, lat: lat, long: long, preview: eventPreview, ratings: [])
                    events.append(event)
                }
            }
        } catch {
            print("Data unable to be parsed: ")
            print(data)
        }
        return events
    }

    
    // Use the getAll endpoint to retrieve all events to recognize
    static func getAll() -> [Event] {
        let apiURL: NSURL = NSURL(string: "https://mediar-api.herokuapp.com/api/events")!
        let data = NSData(contentsOf: apiURL as URL)!
        return getFromBackend(data: data)
    }
}
