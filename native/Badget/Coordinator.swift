//
//  Coordinator.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import Alamofire

class Coordinator: NSObject, NSCoding {
    var date:NSDate
    var time:String
    var distance:Double
    var badge:Badge
    
    init(date: NSDate, time: String, distance: Double, badge: Badge) {
        self.date = date
        self.time = time
        self.distance = distance
        self.badge = badge
        super.init()
    }
    
    func save() {
        let parameters = [
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
            "day": Settings.currentDate,
            "time": self.time,
            "distance": self.distance
        ]
        Alamofire.request(.POST, Settings.apiUrl + "/coordinator", parameters: parameters)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.time = aDecoder.decodeObjectForKey("time") as! String
        self.distance = aDecoder.decodeDoubleForKey("distance")
        self.badge = aDecoder.decodeObjectForKey("badge") as! Badge
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(self.time, forKey: "time")
        aCoder.encodeDouble(self.distance, forKey: "distance")
        aCoder.encodeObject(self.badge, forKey: "badge")
    }
}
