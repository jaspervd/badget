//
//  BadgeDetailViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 16/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgeDetailViewController: UIViewController {
    
    let badge:Badge
    
    var badgeDetailView:BadgeDetailView! {
        get {
            return self.view as! BadgeDetailView
        }
    }
    
    init(badge: Badge) {
        self.badge = badge
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = BadgeDetailView(frame: bounds, badge: badge)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.badgeDetailView.btnClose.addTarget(self, action: "dismissDetail", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        let outPosition = CGPointMake(0, -self.view.frame.height)
        if(parent != nil) {
            self.view.frame.origin = CGPointMake(0, -self.view.frame.height)
        }
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                if(parent != nil) {
                    self.view.frame.origin = CGPointMake(0, 0)
                } else {
                    self.view.frame.origin = outPosition
                }
            }) { (Bool) -> Void in
                if(parent == nil) {
                    self.view.removeFromSuperview()
                }
        }
    }
    
    func dismissDetail() {
        self.willMoveToParentViewController(nil)
        self.removeFromParentViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
