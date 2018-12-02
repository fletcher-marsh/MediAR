//
//  Plane.swift
//  MediAR
//
//  Created by Fletcher Marsh on 11/9/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import Foundation
import ARKit

class Plane : Element {
  //Store information for segue's into other views later.
  
  init(referenceImage: ARReferenceImage) {
    // Store matched poster image
    super.init(referenceImage)
    
    // Initialize plane size with image specs
    let geometry = SCNPlane(width: referenceImage.physicalSize.width,
                             height: referenceImage.physicalSize.height)
    
    // Add node to become child of root node
    self.displayNode = SCNNode(geometry: geometry)
    
    // Be able to somewhat see poster under plane
    self.displayNode.opacity = 0.75
    
    // Plane initializes as being oriented against flat dimensions, change to be vertical
    self.displayNode.eulerAngles.x = -.pi / 2
  }

}
