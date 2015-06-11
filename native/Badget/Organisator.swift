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
    
    init(date: NSDate, friends: Int) {
        self.date = date
        self.friends = friends
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.friends = aDecoder.decodeIntegerForKey("friends")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeInteger(self.friends, forKey: "friends")
    }
}
