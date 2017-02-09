//
//  DetailToDoViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/8/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit

class DetailToDoViewController: UIViewController {

    @IBOutlet weak var goalLabel: UILabel!
    var goalText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goalLabel.text = goalText
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
