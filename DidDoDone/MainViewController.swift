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
    let user = FIRAuth.auth()?.currentUser?.uid
    var dbGoals = [String: Dictionary<String, String>]()
    var goals:[Goal]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        toDoTableView.rowHeight = UITableViewAutomaticDimension
        toDoTableView.estimatedRowHeight = 100
        
//        ref.observe(FIRDataEventType.value, with: { (snapshot) in
//            self.dictionary = snapshot.value as? [String : Any] ?? [:]
//            print("Saved dictionary:")
//            print(self.dictionary)
//            
//            print("Bound user:")
//            print(self.dictionary.count)
//        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    
    func getUserInfo(){
        ref.child("user").child(user!).observeSingleEvent(of: .value, with: { (snapshot) in
            if (!(snapshot.value is NSNull)) {
                self.dbGoals = snapshot.value as! [String : Dictionary<String, String>]
                self.goals = Goal.DBToArray(dictionary: self.dbGoals)
                
                self.toDoTableView.reloadData()
//                let username = value?["username"] as? String ?? ""
//                let user = User.init(username: username)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
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
        var cellNumber = self.dbGoals.count
        if (cellNumber == 0) {
            cellNumber = 1
        }
        return cellNumber
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! GoalCell
        
        let row = indexPath.row
        if (self.goals == nil) {
            cell.goalNameLabel.text = "You haven't set any goals yet!"
            cell.statusImage.image = UIImage(named:"")
        } else {
            cell.setGoalCell(goal: self.goals[row])
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowToDoDetailsSegue") {
            let cell = sender as! GoalCell
            let index = toDoTableView.indexPath(for: cell)
            let row = index!.row
            
            let detailView = segue.destination as! DetailGoalViewController
//            View controller isn't fully initialized yet so label cannot be written too directly
            detailView.goal = self.goals[row]
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        Repeats because segue is already bound in storyboard
//        performSegue(withIdentifier: "ShowToDoDetailsSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

