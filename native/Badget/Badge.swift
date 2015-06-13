//
//  Badge.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class Badge: NSObject, NSCoding {
    let id:Int
    let title:String
    let goal:String
    let image:UIImage
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }
    
    init(id: Int, title: String, goal: String, image: UIImage) {
        self.id = id
        self.title = title
        self.goal = goal
        self.image = image
        super.init()
    }
    
    override init() {
        self.id = 0
        self.title = ""
        self.goal = ""
        self.image = UIImage()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeIntegerForKey("id")
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.goal = aDecoder.decodeObjectForKey("goal") as! String
        self.image = aDecoder.decodeObjectForKey("image") as! UIImage
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(self.id, forKey: "id")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.goal, forKey: "goal")
        aCoder.encodeObject(self.image, forKey: "image")
    }
    
    func save() {
        if(count(self.title) > 0) {
            let entity = NSEntityDescription.entityForName("Badge", inManagedObjectContext: self.appDelegate.managedObjectContext!)
            let badge = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:self.appDelegate.managedObjectContext!)
            badge.setValue(self.id, forKey: "plistId")
            badge.setValue(Settings.currentDate, forKey: "achievedDate")
            
            var error:NSError?
            if(!appDelegate.managedObjectContext!.save(&error)) {
                println("Couldn't save \(error), \(error?.userInfo)")
            }
            
            let parameters = [
                "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
                "title": self.title,
                "goal": self.goal,
                "photo_url": "\(self.title.lowercaseString).png"
            ]
            Alamofire.request(.POST, Settings.apiUrl + "/badges", parameters: parameters as? [String : AnyObject])
        }
    }
    
    class func loadPlist() -> Array<Badge> {
        let path = NSBundle.mainBundle().URLForResource("Badges", withExtension: "plist")
        let tempArr = NSArray(contentsOfURL: path!)
        return BadgeFactory.createFromArray(tempArr!)
    }
}
