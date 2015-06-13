//
//  BadgesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 02/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreData

class BadgesViewController: UIViewController {
    
    var badges:Array<BadgeViewController> = []
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Badges"
        self.view.backgroundColor = Settings.bgColor
        
        let possibleBadges = Badge.loadPlist()
        
        let entity = NSEntityDescription.entityForName("Badge", inManagedObjectContext: self.appDelegate.managedObjectContext!)
        let fetchRequest = NSFetchRequest(entityName: "Badge")
        var error:NSError?
        
        let achievedBadges = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        for badge in achievedBadges {
            var badgeVC = BadgeViewController(badge: possibleBadges[badge.valueForKey("plistId") as! Int])
            self.view.addSubview(badgeVC.view)
            self.badges.append(badgeVC)
        }
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
