//
//  ScoreViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let header:String
    let feedback:String
    let badge:Badge?
    
    var scoreView:ScoreView! {
        get {
            return self.view as! ScoreView
        }
    }
    
    init(header: String, feedback: String, badge: Badge) {
        self.header = header
        self.feedback = feedback
        self.badge = badge
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.badge != nil) {
            let badgeVC = BadgeViewController(badge: self.badge!)
            self.addChildViewController(badgeVC)
            self.scoreView.showBadge(badgeVC.badgeView)
        }
        
        self.scoreView.btnClose.addTarget(self, action: "closeHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func closeHandler() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = ScoreView(frame: bounds, header: self.header, feedback: self.feedback, badge: self.badge)
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
