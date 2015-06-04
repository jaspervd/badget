//
//  Masterscout.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Masterscout: NSObject, NSCoding {
    var time:Int
    
    init(time: Int) {
        self.time = time
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.time = aDecoder.decodeIntegerForKey("time")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.time, forKey: "time")
    }
}
