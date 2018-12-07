//
//  DetailsViewController.swift
//  MediAR
//
//  Created by bobdabuild on 11/9/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var movietitle: UILabel!
    @IBOutlet var moviedesc: UILabel!

    override func viewDidLoad() {
      super.viewDidLoad()
      self.navigationController?.navigationBar.isHidden = true;
        
        moviedesc.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
