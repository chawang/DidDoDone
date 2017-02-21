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
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        signUpButton.layer.cornerRadius = loginButton.layer.cornerRadius
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if (error != nil) {
                let message = error as! NSError
                self.errorMessageLabel.text = message.localizedDescription
                self.errorMessageLabel.isHidden = false
            } else {
                self.performSegue(withIdentifier: "LoginSegue", sender: user)
            }
        }
    }

    @IBAction func onCreate(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if (error != nil) {
                let message = error as! NSError
                self.errorMessageLabel.text = message.localizedDescription
                self.errorMessageLabel.isHidden = false
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
