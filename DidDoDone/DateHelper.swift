//
//  DateHelper.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/28/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit

class DateHelper {
    let formatter = DateFormatter()
    let calendar = Calendar.current
    
    init () {
        formatter.dateFormat = "yyyy-MM-dd///HH:mm.ss"
    }

    func dateToString() -> String {
        let date = Date()
        
        let dateAsString = formatter.string(from: date)
        
        return dateAsString
    }
    
    func stringToDate(string: String) -> Date {
        let stringToDate = self.formatter.date(from: string)
        
        return stringToDate!
    }
    
    func intervalBetween(date: String, frequency: String) {
        let savedDate = stringToDate(string: date)
        let currentDate = Date()
        
        var interval: DateComponents
        var diff: Int
        
        switch (frequency) {
        case "daily":
            interval = calendar.dateComponents([.day], from: savedDate, to: currentDate)
            diff = interval.day!
        case "weekly":
            interval = calendar.dateComponents([.day], from: savedDate, to: currentDate)
            diff = (interval.day!)%7
        case "monthly":
            interval = calendar.dateComponents([.month], from: savedDate, to: currentDate)
            diff = interval.month!
        default:
            print("No suitable frequency found")
        }
        
    }
    
    class func IntervalToString(interval: TimeInterval) -> String {
        let ti = NSInteger(interval)
        
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
}
