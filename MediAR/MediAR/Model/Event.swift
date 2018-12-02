//
//  Event.swift
//  MediAR
//
//  Created by bobdabuild on 11/30/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import Foundation

class Event {
    let title : String
    let imgurkey : String
    let desc : String
    let lat : Float
    let long : Float
    let preview : String
    
    
    init(title: String, imagelink: String, desc: String, lat: Float, long: Float, preview: String) {
        self.title = title
        self.imgurkey = imagelink
        self.desc = desc
        self.lat = lat
        self.long = long
        self.preview = preview
    }
}
