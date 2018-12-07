//
//  HistoryViewController.swift
//  MediAR
//
//  Created by Fletcher Marsh on 12/7/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
  var events : [Event] = []
  
  func viewWillAppear() {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.isTranslucent = false
    // Do any additional setup after loading the view.
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
