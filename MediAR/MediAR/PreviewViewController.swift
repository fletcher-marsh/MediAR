//
//  PreviewViewController.swift
//  MediAR
//
//  Created by bobdabuild on 11/8/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PreviewViewController: UIViewController {
    // Preview video id
    var videoID = "vjnqABgxfO0";
    
    // Interaction
    @IBOutlet var playerView: YTPlayerView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerView.load(withVideoId: self.videoID);
    }
}
