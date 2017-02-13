//
//  LoginViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/12/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if (error != nil) {
                print(error)
            } else {
                self.performSegue(withIdentifier: "LoginSegue", sender: user)
            }
        }
    }

    @IBAction func onCreate(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if (error != nil) {
                print(error)
            } else {
                self.performSegue(withIdentifier: "LoginSegue", sender: user)
            }
        }
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
