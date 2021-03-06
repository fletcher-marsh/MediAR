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
import CoreLocation

import SwiftyJSON

// MARK: - Protocols

protocol OpeningRouteDelegate {
    func openMap(destination: CLLocation)
}

protocol OpeningDetailsDelegate {
    func openDetails(title: String, ratings: String, description: String)
}


class ViewController: UIViewController, ARSCNViewDelegate {

    let configuration = ARWorldTrackingConfiguration()
    var events: [Event] = []
    var childNodes: [SCNNode] = []
    var liveEvents: [String: Event] = [:]
    var previewVideoID = "vjnqABgxfO0"
    var toLat : Float?
    var toLong : Float?
    var eventName : String?
    var desc : String?
    var ratings : [String]?
    

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var descButton: UIButton!
    @IBOutlet weak var ratingsButton: UIButton!
    @IBOutlet weak var previewButton: UIButton!
    
    // MARK: - Views

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black;
        
        sceneView.delegate = self
        
        configuration.detectionImages = []
        
        // Grab Events Data
        events = Event.getAll()
        loadEventImages(events: events)
        
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
       
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - ARSCNViewDelegate

    func getCurrentInfo (_ node: SCNNode, _ img: ARReferenceImage) {
        self.childNodes.append(node)
        for e in self.events {
            if (e.title == img.name!) {
                self.liveEvents[e.title] = e
            }
        }
    }
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // Root node for scene
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            // We found a matching anchor, draw plane over it for UI
            let img = imageAnchor.referenceImage
            let newPlane = Plane(referenceImage: img)
            newPlane.addToScene(node)
            getCurrentInfo(newPlane.displayNode, img)
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
    
    func updateSelectedInfo(_ name: String) {
        self.previewVideoID = self.liveEvents[name]!.preview
        self.toLat = self.liveEvents[name]!.lat
        self.toLong = self.liveEvents[name]!.long
        self.desc = self.liveEvents[name]!.desc
        self.eventName = self.liveEvents[name]!.title
        self.ratings = self.liveEvents[name]!.ratings
    }
    
    func highlightSelected(_ n: SCNNode) {
        var temp = n;
        if let geo = n.geometry! as? SCNText {
            let name = geo.string as? String
            updateSelectedInfo(name!)
            temp = n.parent!
        } else if n.geometry! is SCNPlane {
            let child = n.childNodes[0].geometry! as? SCNText
            let name = child!.string as? String
            updateSelectedInfo(name!)
        } else {
            return
        }
        
        temp.opacity = 0.85;
        for node in self.childNodes {
            if (node != n) {
                node.opacity = 0.4;
            }
        }
    }
    
    func clearSelected() {
        for node in self.childNodes {
            node.opacity = 0.4;
        }
    }
    
    func reveal(button: UIButton) {
        button.isHidden = false
        UIView.animate(withDuration: 0.6, animations: {
            button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }, completion: {
            _ in UIView.animate(withDuration: 0.6) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    func hide(button: UIButton) {
        button.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLoc = touches.first?.location(in: sceneView)
        let touchedNode = sceneView?.hitTest(touchLoc!)
        if (touchedNode!.count > 0) {
            highlightSelected(touchedNode![0].node);
            reveal(button: self.mapButton)
            reveal(button: self.descButton)
            reveal(button: self.ratingsButton)
            reveal(button: self.previewButton)
        } else {
            clearSelected();
            hide(button: self.mapButton)
            hide(button: self.descButton)
            hide(button: self.ratingsButton)
            hide(button: self.previewButton)
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is PreviewViewController {
            let pvc = segue.destination as? PreviewViewController
            pvc?.videoID = self.previewVideoID
        }
        else if segue.destination is DetailsViewController {
            let dvc = segue.destination as? DetailsViewController
            dvc?.mDesc = self.desc!
            dvc?.mTitle = self.eventName!
        } else if segue.destination is RatingsViewController {
            let rvc = segue.destination as? RatingsViewController
            let ratingSplit : [[String]] = self.ratings!.map { $0.components(separatedBy: "+") }
            rvc?.ratingSources = ratingSplit.map { $0[0] }
            rvc?.ratingValues = ratingSplit.map { $0[1] }
        }
    }
    
    // MARK: - External Calls
    
    @IBAction func openMap(_ sender: Any) {
        //Working in Swift new versions.
        
        guard let url = URL(string: "https://www.google.com/maps/dir/?api=1&origin=CMU&destination=\(self.toLat!),\(self.toLong!)") else { //Sample URL
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
    
    // Mark: - URL Loading
    
    func storeRatings(event: Event) {
        do {
            let plussedString = event.title.replacingOccurrences(of: " ", with: "+")
            let omdbURL: NSURL = NSURL(string: "https://omdbapi.com/?apikey=9c2d5c4d&t=\(plussedString)")!
            
            let data = NSData(contentsOf: omdbURL as URL)!
            
            let swiftyjson = try JSON(data: data as Data)
            
            var ratings = [String]();
            
            for(_, rating) in swiftyjson["Ratings"] {
                ratings.append("\(rating["Source"])+\(rating["Value"])")
            }
            event.ratings = ratings
        } catch { event.ratings = [String](); }
    }
    
    // Mark: - Image Loading

    
    func loadEventImages(events: [Event]) {
      //  let arImages = [ARReferenceImage]
        
        func loadEventImage(data: Data, name: String) {
            guard let imgurImg = UIImage(data: data),
                
                let imageToCIImage = CIImage(image: imgurImg),
                
                let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage) else { return }
            
            let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.1)
            
            arImage.name = name
            configuration.detectionImages?.insert(arImage)
            sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }
        
        for event in events {
            let url = URL(string: "https://i.imgur.com/" + event.imgurkey)
            
            let downloadImageTask = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                
                if error != nil {
                  print("Error occured.")
                  print(error!)
                  return
                }
                
                DispatchQueue.main.async {
                    self.storeRatings(event: event)
                    loadEventImage(data: data!, name: event.title)
                }
            })
            
            downloadImageTask.resume()
        }
        
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage?
    {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
}
