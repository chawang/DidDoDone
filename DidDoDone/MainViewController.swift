//
//  ViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/3/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var completedButton: UIButton!
    let defaults = UserDefaults.standard
    
    let ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        toDoTableView.rowHeight = UITableViewAutomaticDimension
        toDoTableView.estimatedRowHeight = 100
    }

    @IBAction func decrement(_ sender: Any) {
        let initial = Int(intervalLabel.text!)
        let unformattedText = initial! - 1
//        let formattedText = String(format: "%d", unformattedText)
        intervalLabel.text = "\(unformattedText)"
    }
    @IBAction func increment(_ sender: Any) {
        let initial = Int(intervalLabel.text!)
        let unformattedText = initial! + 1
//        let formattedText = String(format: "%d", unformattedText)
        intervalLabel.text = "\(unformattedText)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        cell.setToDoCell(row: indexPath.row)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Repeats because segue is already bound in storyboard
//        performSegue(withIdentifier: "ShowToDoDetailsSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowToDoDetailsSegue") {
            let cell = sender as! ToDoCell
            let index = toDoTableView.indexPath(for: cell)
            let row = index?.row
            
            let detailView = segue.destination as! DetailToDoViewController
//            View controller isn't fully initialized yet so label cannot be written too directly
//            detailView.goalLabel.text = "testing"
            detailView.goalText = "\(cell.toDoItemLabel.text!) of row:\(row!)"
        }
    }

}

