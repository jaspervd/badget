//
//  BadgesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 02/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreData

class BadgesViewController: UIViewController, BadgeDelegate {
    
    var badges:Array<BadgeViewController> = []
    
    var badgesView:BadgesView {
        get {
            return self.view as! BadgesView
        }
    }
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        let possibleBadges = Badge.loadPlist()
        
        let entity = NSEntityDescription.entityForName("Badge", inManagedObjectContext: self.appDelegate.managedObjectContext!)
        let fetchRequest = NSFetchRequest(entityName: "Badge")
        var error:NSError?
        
        var delay = 0.3
        var rows = Int(ceil(CGFloat(possibleBadges.count) / 5))
        var xPos:CGFloat = 0
        var yPos:CGFloat = 0
        let achievedBadges = appDelegate.managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]
        for (index, badge) in enumerate(achievedBadges) {
            xPos = 0
            yPos = 0
            var badgeVC = BadgeViewController(badge: possibleBadges[badge.valueForKey("plistId") as! Int])
            self.badgesView.badges.addSubview(badgeVC.view)
            badgeVC.view.transform = CGAffineTransformMakeScale(1.5, 1.5)
            badgeVC.view.alpha = 0
            UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                badgeVC.view.transform = CGAffineTransformMakeScale(1, 1)
                badgeVC.view.alpha = 1
                }, completion: nil)
            delay += 0.1
            
            switch index % 5 {
            case 0:
                xPos = 0
            case 1:
                xPos = 85
            case 2:
                xPos = 170
            case 3:
                xPos = 43
                yPos = 70
            case 4:
                xPos = 128
                yPos = 70
            default:
                xPos = 0
                yPos = 0
            }

            yPos += floor(CGFloat(index) / 5) * 140
            badgeVC.view.frame = CGRectMake(xPos, yPos, 77, 87)
            badgeVC.delegate = self
            
            self.badges.append(badgeVC)
        }
        
        self.badgesView.badges.sizeToFit()
    }
    
    func showDetails(badge: Badge) {
        let badgeDetailVC = BadgeDetailViewController(badge: badge)
        self.addChildViewController(badgeDetailVC)
        self.view.addSubview(badgeDetailVC.view)
        badgeDetailVC.didMoveToParentViewController(self)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = BadgesView(frame: bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
