//
//  Masterscout.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Masterscout: NSObject, NSCoding {
    var time:String
    var distance:Double
    
    init(time: String, distance: Double) {
        self.time = time
        self.distance = distance
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.time = aDecoder.decodeObjectForKey("time") as! String
        self.distance = aDecoder.decodeDoubleForKey("distance")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.time, forKey: "time")
        aCoder.encodeDouble(self.distance, forKey: "distance")
    }
}
