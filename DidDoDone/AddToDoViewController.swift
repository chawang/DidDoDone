//
//  AddToDoViewController.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/7/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var repetitionTextField: UITextField!
    @IBOutlet weak var repetitionPicker: UIPickerView!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var durationPicker: UIPickerView!
   
    let repetition = ["second(s)", "minutes(s)", "hour(s)", "mile(s)", "km(s)", ]
    let duration = ["day(s)", "week(s)", "month(s)", "year(s)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repetitionPicker.dataSource = self
        repetitionPicker.delegate = self
        
        durationPicker.dataSource = self
        durationPicker.delegate = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == durationPicker) {
            return duration.count
        } else if (pickerView == repetitionPicker) {
            return repetition.count
        } else {
            fatalError("Unhandled picker \(pickerView)")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .center
        var title: String
        if (pickerView == durationPicker) {
            title = duration[row]
            let myTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "Optima", size: 15.0)!,NSForegroundColorAttributeName:UIColor.black])
            pickerLabel.attributedText = myTitle
            return pickerLabel
        } else if (pickerView == repetitionPicker) {
            title = repetition[row]
            let myTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName:UIFont(name: "Optima", size: 15.0)!,NSForegroundColorAttributeName:UIColor.black])
            pickerLabel.attributedText = myTitle
            return pickerLabel
        } else {
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
