//
//  Region.swift
//  Badget
//
//  Created by Jasper Van Damme on 13/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreLocation

class Region: NSObject {
    
    let name:String
    let radius:CLLocationDistance
    let longitude:CLLocationDegrees
    let latitude:CLLocationDegrees
    
    init(name: String, radius: Double, longitude: Double, latitude: Double) {
        self.name = name
        self.radius = radius as CLLocationDistance
        self.longitude = longitude as CLLocationDegrees
        self.latitude = latitude as CLLocationDegrees
    }
   
    class func loadPlist() -> Array<Region> {
        let path = NSBundle.mainBundle().URLForResource("Regions", withExtension: "plist")
        let tempArr = NSArray(contentsOfURL: path!)
        return RegionFactory.createFromArray(tempArr!)
    }
}
