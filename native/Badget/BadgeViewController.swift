//
//  BadgeViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgeViewController: UIViewController {
    
    let badge:Badge
    
    var badgeView:BadgeView! {
        get {
            return self.view as! BadgeView
        }
    }
    
    init(badge: Badge) {
        self.badge = badge
        super.init(nibName: nil, bundle: nil)
   }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.badgeView.imageBtn.addTarget(self, action: "showDetails", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showDetails() {
        println(badge.title, badge.goal)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = BadgeView(frame: bounds, badge: self.badge)
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
