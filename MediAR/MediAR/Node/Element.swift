//
//  Element.swift
//  MediAR
//
//  Created by Fletcher Marsh on 11/30/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import Foundation
import ARKit

class Element {
  var input : Any?
  var displayNode : SCNNode
  
  init (_ input: Any) {
    self.input = input
    // Default display node, to be overwritten in child classes
    displayNode = SCNNode(geometry: SCNText(string: "hello", extrusionDepth: 0.1))
  }
  
  func addToScene(_ parentNode: SCNNode) {
    // Make this instance a child node to be displayed
    parentNode.addChildNode(self.displayNode)
  }
}
