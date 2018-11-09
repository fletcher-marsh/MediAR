//
//  Plane.swift
//  MediAR
//
//  Created by Fletcher Marsh on 11/9/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import Foundation
import ARKit

class Plane {
  let referenceImage : ARReferenceImage
  let geometry : SCNPlane
  let planeNode : SCNNode
  
  init(imageAnchor: ARImageAnchor) {
    // Store matched poster image
    self.referenceImage = imageAnchor.referenceImage
    
    // Initialize plane size with image specs
    self.geometry = SCNPlane(width: self.referenceImage.physicalSize.width,
                             height: self.referenceImage.physicalSize.height)
    
    // Add node to become child of root node
    self.planeNode = SCNNode(geometry: self.geometry)
    
    // Be able to somewhat see poster under plane
    self.planeNode.opacity = 0.25
    
    // Plane initializes as being oriented against flat dimensions, change to be vertical
    self.planeNode.eulerAngles.x = -.pi / 2
  }
  
  func addPlaneToScene(_ parentNode: SCNNode) {
    // Make this instance a child node to be displayed
    parentNode.addChildNode(self.planeNode)
  }
}
