//
//  BadgeFactory.swift
//  Badget
//
//  Created by Jasper Van Damme on 13/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgeFactory: NSObject {
   
    class func createFromArray(plistArray:NSArray) -> Array<Badge> {
        var badgesArray = Array<Badge>()
        for (index, badgeDict) in enumerate(plistArray) {
            let title = badgeDict["title"] as! String
            let goal = badgeDict["goal"] as! String
            let image = badgeDict["image"] as! String
            
            badgesArray.append(Badge(id: index, title: title, goal: goal, image: UIImage(named: image)!))
        }
        
        return badgesArray
    }
    
}
