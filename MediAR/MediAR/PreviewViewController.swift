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
    
    @IBOutlet var playerView: YTPlayerView!
    var videoID = "vjnqABgxfO0";
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerView.load(withVideoId: self.videoID);

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
