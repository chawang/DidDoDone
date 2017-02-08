//
//  ViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/3/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var completedButton: UIButton!
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

