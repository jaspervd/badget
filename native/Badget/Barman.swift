//
//  Barman.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Barman: NSObject, NSCoding {
    var date:NSDate
    var angle:Int
    var seconds:Int
    var badge:Badge
    
    init(date: NSDate, angle: Int, seconds: Int, badge: Badge) {
        self.date = date
        self.angle = angle
        self.seconds = seconds
        self.badge = badge
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.angle = aDecoder.decodeIntegerForKey("angle")
        self.seconds = aDecoder.decodeIntegerForKey("seconds")
        self.badge = aDecoder.decodeObjectForKey("badge") as! Badge
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeInteger(self.angle, forKey: "angle")
        aCoder.encodeInteger(self.seconds, forKey: "seconds")
        aCoder.encodeObject(self.badge, forKey: "badge")
    }
}
