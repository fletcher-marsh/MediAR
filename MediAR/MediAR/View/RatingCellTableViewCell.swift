///Users/bobdabuild/Desktop/442/project/MediAR/MediAR/MediAR/RatingsViewController.swift
//  RatingCellTableViewCell.swift
//  MediAR
//
//  Created by bobdabuild on 12/6/18.
//  Copyright © 2018 MediAR. All rights reserved.
//

import UIKit

class RatingCellTableViewCell: UITableViewCell {
  
    @IBOutlet weak var rSource: UILabel!
    @IBOutlet weak var rValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
