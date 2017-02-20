//
//  toDoTableViewCell.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/5/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit
import Foundation

class GoalCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var goalNameLabel: UILabel!
    
    func setGoalCell (goal Goal: Goal) {
        goalNameLabel.text = Goal.goalName
        statusImage.image = UIImage(named:"Ok")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
