//
//  Helpers.swift
//  DidDoDone
//
//  Created by Charles Wang on 2/15/17.
//  Copyright © 2017 Charles Wang. All rights reserved.
//

import UIKit

class Helpers: NSObject {
    
    class func IntervalToString(interval: TimeInterval) -> String {
        
        let ti = NSInteger(interval)
        
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
    
    class func DateToString() -> String {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd E HH:mm:ss.S"
        
        let dateAsString = formatter.string(from: date)
        StringToDate(string: dateAsString)
        return dateAsString
    }
    class func StringToDate(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd E HH:mm:ss.S"
        
        let stringToDate = formatter.date(from: string)
        print(stringToDate!)
    }
}
