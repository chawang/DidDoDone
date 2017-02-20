//
//  AddToDoViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/7/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit
import Firebase

class AddGoalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var goalTitleTextField: UITextField!
    @IBOutlet weak var repetitionTextField: UITextField!
//    @IBOutlet weak var repetitionPicker: UIPickerView!
    @IBOutlet weak var frequencyPicker: UIPickerView!
   
    let ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    
//    let repetition = ["second(s)", "minutes(s)", "hour(s)", "mile(s)", "km(s)", ]
    let frequency = ["daily", "weekly", "monthly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        repetitionPicker.dataSource = self
//        repetitionPicker.delegate = self
        
        frequencyPicker.dataSource = self
        frequencyPicker.delegate = self
        
        goalTitleTextField.delegate = self
        repetitionTextField.delegate = self
        
        repetitionTextField.keyboardType = UIKeyboardType.numberPad
        addDoneOverKeyboard()
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveGoal(_ sender: Any) {
        let goal = goalTitleTextField.text!
        let rep = repetitionTextField.text!
        let freq = frequency[frequencyPicker.selectedRow(inComponent: 0)]
        let dateCreated = Date()
        let dateString = dateToString(dateCreated)
        
        let savedInfo = ["repetition":rep, "frequency":freq, "created":dateString]

        //TODO:write a check for duplicates
        self.ref.child("user/\((user?.uid)!)/\(goal)").setValue(savedInfo)
        dismiss(animated: true, completion: nil)
        
        //Below code overwrites all child nodes
//        self.ref.child("goal").child((user?.uid)!).setValue([goal:rep])
    }

    func dateToString(_ date:Date) -> String {
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd///HH:mm.ss"
        let dateString = myDateFormatter.string(from: date)
        
        return dateString
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == goalTitleTextField) {
            repetitionTextField.becomeFirstResponder()
        }
        return false
    }
    
    func addDoneOverKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        var items = Array<UIBarButtonItem>()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        
        repetitionTextField.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        repetitionTextField.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == frequencyPicker) {
            return frequency.count
        }
//        else if (pickerView == repetitionPicker) {
//            return repetition.count
//        }
        else {
            fatalError("Unhandled picker \(pickerView)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .center
        var title: String
        if (pickerView == frequencyPicker) {
            title = frequency[row]
            let myTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "Optima", size: 15.0)!,NSForegroundColorAttributeName:UIColor.black])
            pickerLabel.attributedText = myTitle
            return pickerLabel
        }
//        else if (pickerView == repetitionPicker) {
//            title = repetition[row]
//            let myTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "Optima", size: 15.0)!,NSForegroundColorAttributeName:UIColor.black])
//            pickerLabel.attributedText = myTitle
//            return pickerLabel
//        }
        else {
            fatalError("Unhandled picker \(pickerView)")
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
