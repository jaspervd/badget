//
//  LocationFactory.swift
//  Badget
//
//  Created by Jasper Van Damme on 13/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class RegionFactory: NSObject {
    
    class func createFromArray(plistArray:NSArray) -> Array<Region> {
        var regionsArray = Array<Region>()
        for regionDict in plistArray {
            let name = regionDict["name"] as! String
            let radius = regionDict["radius"] as! Double
            let longitude = regionDict["longitude"] as! Double
            let latitude = regionDict["latitude"] as! Double
                
            regionsArray.append(Region(name: name, radius: radius, longitude: longitude, latitude: latitude))
        }
        
        return regionsArray
    }

}
