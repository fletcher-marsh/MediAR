//
//  EventNode.swift
//  MediAR
//
//  Created by bobdabuild on 12/2/18.
//  Copyright © 2018 MediAR. All rights reserved.
//
// A specialized node to capture event information.

import SceneKit

class EventNode : SCNNode {
    
    
    private var title: String?
    private var preview: String?
    private var lat: Float?
    private var long: Float?
    private var storelink: String?
    private var desc: String?
    private var rating: String?
    
    typealias maplocation = (Float, Float)
    
    init(title: String?, preview: String?, lat: Float?, long: Float?, storelink: String?, desc: String?, rating: String?) {
        super.init()
        self.title = title
        self.preview = preview
        self.lat = lat
        self.long = long
        self.storelink = storelink
        self.desc = desc
        self.rating = rating
    }
    
    func getTitle() -> String? {
        return self.title
    }
    
    func getLocation() -> maplocation? {
        if let latitude = self.lat {
            if let longitude = self.long {
                return (latitude,longitude)
            } else { return nil }
        } else { return nil }
    }
    
    func getPreview() -> String? {
        return self.preview
    }
    
    func getStoreLink() -> String? {
        return self.storelink
    }
    
    func getDescription() -> String? {
        return self.desc
    }
    
    func getRating() -> String? {
        return self.rating
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
