//
//  RatingsViewController.swift
//  MediAR
//
//  Created by bobdabuild on 12/6/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView?
    
    var ratingSources : [String]?
    var ratingValues : [String]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingSources!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingsCell", for: indexPath) as! RatingCellTableViewCell
        cell.rSource.text = ratingSources![indexPath.item]
        cell.rValue.text = ratingValues![indexPath.item]
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(ratingSources, ratingValues)
        tableView?.dataSource = self
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
