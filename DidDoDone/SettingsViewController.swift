//
//  SettingsViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/3/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    let firebaseAuth = FIRAuth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignOut(_ sender: Any) {
        do {
            try firebaseAuth?.signOut()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userDidLogoutNotification"), object: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
