//
//  DetailsViewController.swift
//  MediAR
//
//  Created by bobdabuild on 11/9/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    // Default values to be overwritten by detected data
    var mTitle = "Grinch"
    var mDesc = "A spiteful green fellow attempts to ruin Christmas for a small town"
    
    // Interaction
    @IBOutlet var movietitle: UILabel!
    @IBOutlet var moviedesc: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        moviedesc.numberOfLines = 0
        movietitle.text = mTitle
        moviedesc.text = mDesc
    }
}
