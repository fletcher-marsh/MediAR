//
//  ViewController.swift
//  MediAR
//
//  Created by Fletcher Marsh on 10/31/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

import AVKit
import MapKit



// MARK: - Protocols

protocol OpeningRouteDelegate {
    func openMap(destination: CLLocation)
}

protocol OpeningDetailsDelegate {
    func openDetails(title: String, ratings: String, description: String)
}

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var previewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene (default ship scene)
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        // sceneView.scene = scene
    }
  
    // Fade plane out of view
    var imageHighlightAction: SCNAction {
      return .sequence([
        .wait(duration: 0.25),
        .fadeOpacity(to: 0.85, duration: 1.50),
        .fadeOpacity(to: 0.15, duration: 1.50),
        .fadeOpacity(to: 0.85, duration: 1.50),
        .fadeOut(duration: 0.75),
        .removeFromParentNode()
      ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let referenceImages =
            // Load reference images to be scanned for into config
            ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
          fatalError("Missing expected asset catalog resources.")
        }
      
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
      
        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // Root node for scene
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            // We found a matching anchor, draw plane over it for UI
            let img = imageAnchor.referenceImage
            let newPlane = Plane(referenceImage: img)
            newPlane.addToScene(node)
            let newText = Text(input: img.name!)
            newText.addToScene(newPlane.displayNode)
        }
        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
  
    
    // MARK: - Buttons/Interaction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLoc = touches.first?.location(in: sceneView)
        let touchedNode = sceneView?.hitTest(touchLoc!)
        if (touchedNode!.count > 0) {
            self.mapButton.isHidden = false
            self.previewButton.isHidden = false
        } else {
            self.mapButton.isHidden = true
            self.previewButton.isHidden = true
        }
        
    }
    
    // MARK: - External Calls
    
    @IBAction func openMap(_ sender: Any) {
        //Working in Swift new versions.
        guard let url = URL(string: "https://www.google.com/maps/dir/?api=1&origin=Google+Pyrmont+NSW&destination=QVB&destination_place_id=ChIJISz8NjyuEmsRFTQ9Iw7Ear8&travelmode=walking") else { //Sample URL
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        
        let webView:UIWebView = UIWebView()
        
        let mapURLRequest:URLRequest = URLRequest(url: url)
        
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = UIViewController()
        controller.view = webView
        
        webView.loadRequest(mapURLRequest)
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            
        }
        
    }
    
}
