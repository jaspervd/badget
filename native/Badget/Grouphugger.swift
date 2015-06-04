//
//  Grouphugger.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Grouphugger: NSObject, NSCoding {
    var friends:Int!
    
    required init(coder aDecoder: NSCoder) {
        self.friends = aDecoder.decodeIntegerForKey("friends")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.friends, forKey: "friends")
    }
}
