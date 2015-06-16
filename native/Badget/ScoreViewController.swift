//
//  ScoreViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let feedback:String
    let badge:Badge?
    
    var scoreView:ScoreView! {
        get {
            return self.view as! ScoreView
        }
    }
    
    init(feedback: String, badge: Badge) {
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
        
        self.title = ""
        self.scoreView.btnOk.addTarget(self, action: "closeHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func closeHandler() {
        println("yow")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = ScoreView(frame: bounds, feedback: self.feedback)
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
