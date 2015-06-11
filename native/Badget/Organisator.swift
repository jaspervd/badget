//
//  Organisator.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Organisator: NSObject, NSCoding {
    var date:NSDate
    var friends:Int
    var badge:Badge
    
    init(date: NSDate, friends: Int, badge: Badge) {
        self.date = date
        self.friends = friends
        self.badge = badge
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.friends = aDecoder.decodeIntegerForKey("friends")
        self.badge = aDecoder.decodeObjectForKey("badge") as! Badge
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeInteger(self.friends, forKey: "friends")
        aCoder.encodeObject(self.badge, forKey: "badge")
    }
}
