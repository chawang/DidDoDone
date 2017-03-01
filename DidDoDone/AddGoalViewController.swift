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
    @IBOutlet weak var setTextField: UITextField!
//    @IBOutlet weak var repetitionPicker: UIPickerView!
    @IBOutlet weak var cyclePicker: UIPickerView!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    
    let ref = FIRDatabase.database().reference()
    let user = FIRAuth.auth()?.currentUser
    
//    let repetition = ["second(s)", "minutes(s)", "hour(s)", "mile(s)", "km(s)", ]
    let cycleArray = ["daily", "weekly", "monthly"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        repetitionPicker.dataSource = self
//        repetitionPicker.delegate = self
        
        cyclePicker.dataSource = self
        cyclePicker.delegate = self
        
        goalTitleTextField.delegate = self
        setTextField.delegate = self
        
        setTextField.keyboardType = UIKeyboardType.numberPad
        addDoneOverKeyboard()
        
        durationSlider.minimumValue = 1
        durationSlider.maximumValue = 365
        durationSlider.setValue(365, animated: true)
        durationLabel.text = "365"
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveGoal(_ sender: Any) {
        let goalTitle = goalTitleTextField.text!
        let set = setTextField.text!
        let cycle = cycleArray[cyclePicker.selectedRow(inComponent: 0)]
        let date = DateHelper().dateToString()
        
        let savedInfo = ["set":set, "cycle":cycle, "duration":durationLabel.text, "created":date ]

        //TODO:write a check for duplicates
        self.ref.child("user/\((user?.uid)!)/\(goalTitle)").setValue(savedInfo)
        dismiss(animated: true, completion: nil)
        
        //Overwrites all child nodes
//        self.ref.child("goal").child((user?.uid)!).setValue([goal:rep])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == goalTitleTextField) {
            setTextField.becomeFirstResponder()
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
        
        setTextField.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        setTextField.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == cyclePicker) {
            return cycleArray.count
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
        if (pickerView == cyclePicker) {
            title = cycleArray[row]
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
        if (row == 0) {
            durationSlider.maximumValue = 365
            durationSlider.setValue(365, animated: true)
            durationLabel.text = "365"
        }
        if (row == 1) {
            durationSlider.maximumValue = 52
            durationSlider.setValue(52, animated: true)
            durationLabel.text = "52"
        }
        if (row == 2) {
            durationSlider.maximumValue = 12
            durationSlider.setValue(12, animated: true)
            durationLabel.text = "12"
        }
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        durationLabel.text = "\(currentValue)"
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
