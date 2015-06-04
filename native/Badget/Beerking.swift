//
//  Beerking.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Beerking: NSObject, NSCoding {
    var angle:Int
    var seconds:Int
    
    init(angle: Int, seconds: Int) {
        self.angle = angle
        self.seconds = seconds
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.angle = aDecoder.decodeIntegerForKey("angle")
        self.seconds = aDecoder.decodeIntegerForKey("seconds")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.angle, forKey: "angle")
        aCoder.encodeInteger(self.seconds, forKey: "seconds")
    }
}
