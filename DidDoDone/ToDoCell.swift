//
//  toDoTableViewCell.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/5/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit
import Foundation

class ToDoCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var toDoItemLabel: UILabel!
    
    func setToDoCell (row theRow: Int) {
        var imageString: String!
        let calculateImage = theRow % 3
        
        switch (calculateImage) {
            case 0:
                imageString = "Ok"
                toDoItemLabel.text = "No Remainder"
            case 1:
                imageString = "Cancel"
                toDoItemLabel.text = "Remainder 1"
            case 2:
                imageString = "Clock"
                toDoItemLabel.text = "Remainder 2"
            default:
                print("Error finding image")
                toDoItemLabel.text = "Error finding row"
        }

        statusImage.image = UIImage(named:imageString)
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
