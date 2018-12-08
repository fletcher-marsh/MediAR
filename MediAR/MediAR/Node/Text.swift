//
//  Text.swift
//  MediAR
//
//  Created by Fletcher Marsh on 11/30/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import Foundation
import ARKit

class Text : Element {
  init (input: String) {
    super.init(input)
    // Text styling
    let text = SCNText(string: input, extrusionDepth: 0.1)
    text.font = UIFont.systemFont(ofSize: 1.0)
    text.flatness = 0.01
    text.firstMaterial?.diffuse.contents = UIColor.black
    
    // Node to be added
    displayNode = SCNNode(geometry: text)
    let size = Float(0.02)
    displayNode.scale = SCNVector3(size, size, size)
    
    // Anchor to parent node (plane)
    snapToPlane()
  }
  
  // Make text flush and centered on plane
  func snapToPlane() {
    var minVec = SCNVector3Zero
    var maxVec = SCNVector3Zero
    (minVec, maxVec) =  self.displayNode.boundingBox
    
    // Take center x/z coords, and lowest y coord to plane
    self.displayNode.pivot = SCNMatrix4MakeTranslation(
      (maxVec.x + minVec.x)/2,
      minVec.y,
      (maxVec.z + minVec.z)/2
    )
  }
}
