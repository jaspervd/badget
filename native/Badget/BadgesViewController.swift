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
        
        self.title = ""
        self.view.backgroundColor = Settings.bgColor
        
        let possibleBadges = Badge.loadPlist()
        
        let entity = NSEntityDescription.entityForName("Badge", inManagedObjectContext: self.appDelegate.managedObjectContext!)
        let fetchRequest = NSFetchRequest(entityName: "Badge")
        var error:NSError?
        
        var delay = 0.3
        let achievedBadges = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        for badge in achievedBadges {
            var badgeVC = BadgeViewController(badge: possibleBadges[badge.valueForKey("plistId") as! Int])
            self.view.addSubview(badgeVC.view)
            badgeVC.view.frame = CGRectMake(100, 100, 77, 87)
            badgeVC.view.transform = CGAffineTransformMakeScale(1.5, 1.5)
            badgeVC.view.alpha = 0.5
            UIView.animateWithDuration(0.8, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                badgeVC.view.transform = CGAffineTransformMakeScale(1, 1)
                badgeVC.view.alpha = 1
                }, completion: nil)
            delay += 0.3
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
