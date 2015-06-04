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
    var distance:Int
    
    init(time: Int, distance: Int) {
        self.time = time
        self.distance = distance
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.time = aDecoder.decodeIntegerForKey("time")
        self.distance = aDecoder.decodeIntegerForKey("distance")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.time, forKey: "time")
        aCoder.encodeInteger(self.distance, forKey: "distance")
    }
}
