//
//  Masterscout.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Masterscout: NSObject, NSCoding {
    var time:String!
    
    required init(coder aDecoder: NSCoder) {
        self.time = aDecoder.decodeObjectForKey("time") as! String?
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.time, forKey: "time")
    }
}
