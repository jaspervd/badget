//
//  Badge.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Badge: NSObject, NSCoding {
    let title:String
    let goal:String
    let image:UIImage
    
    init(title: String, goal: String, image: UIImage) {
        self.title = title
        self.goal = goal
        self.image = image
        super.init()
    }
    
    override init() {
        self.title = ""
        self.goal = ""
        self.image = UIImage()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.goal = aDecoder.decodeObjectForKey("goal") as! String
        self.image = aDecoder.decodeObjectForKey("image") as! UIImage
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.goal, forKey: "goal")
        aCoder.encodeObject(self.image, forKey: "image")
    }
    
    class func loadPlist() -> Array<Badge> {
        let path = NSBundle.mainBundle().URLForResource("Badges", withExtension: "plist")
        let tempArr = NSArray(contentsOfURL: path!)
        return BadgeFactory.createFromArray(tempArr!)
    }
}
