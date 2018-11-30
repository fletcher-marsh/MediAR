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
    let text = SCNText(string: input, extrusionDepth: 0.1)
    text.font = UIFont.systemFont(ofSize: 1.0)
    text.flatness = 0.01
    text.firstMaterial?.diffuse.contents = UIColor.black
    displayNode = SCNNode(geometry: text)
    
    let size = Float(0.04)
    displayNode.scale = SCNVector3(size, size, size)
    
    snapToPlane()
  }
  
  func snapToPlane() {
    var minVec = SCNVector3Zero
    var maxVec = SCNVector3Zero
    (minVec, maxVec) =  self.displayNode.boundingBox
    self.displayNode.pivot = SCNMatrix4MakeTranslation(
      minVec.x + (maxVec.x - minVec.x)/2,
      minVec.y,
      minVec.z + (maxVec.z - minVec.z)/2
    )
//    self.displayNode.eulerAngles.x = -.pi / 2
  }
}
