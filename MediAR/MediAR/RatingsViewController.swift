//
//  RatingsViewController.swift
//  MediAR
//
//  Created by bobdabuild on 12/6/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Rating info
    var ratingSources : [String]?
    var ratingValues : [String]?
    
    // Interaction
    @IBOutlet var tableView : UITableView?
    
    // MARK: - Tables
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingSources!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingsCell", for: indexPath) as! RatingCellTableViewCell
        cell.rSource.text = ratingSources![indexPath.item]
        cell.rValue.text = ratingValues![indexPath.item]
        return cell
    }
    
    // MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        // Do any additional setup after loading the view.
    }
}
