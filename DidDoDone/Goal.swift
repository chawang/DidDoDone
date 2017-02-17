//
//  Goals.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/16/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit

class Goal: NSObject {
    var goalName: String?
    var repetition: Int?
    var frequency: String?
    var dateCreated: Double?
   
    init(goalName: String, dictionary:Dictionary<String, String>){
            self.goalName = goalName
            repetition = Int(dictionary["repetition"]!)
            dateCreated = Double(dictionary["created"]!)
            frequency = dictionary["frequency"]
    }
    
    class func DBToArray(dictionary: Dictionary<String, Dictionary<String, String>>) -> [Goal] {
        var goals = [Goal]()
        
        for goal in dictionary {
            let name = goal.key
            let goalDetails = dictionary[goal.key]
            let allInfo = Goal(goalName: name, dictionary: goalDetails!)
            goals.append(allInfo)
        }
        
        return goals
    }
    
}
