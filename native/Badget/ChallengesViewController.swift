//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreLocation

class ChallengesViewController: UIViewController, UIScrollViewDelegate {
    
    let grouphuggerVC = GrouphuggerViewController()
    let masterscoutVC = MasterscoutViewController()
    let beerkingVC = BeerkingViewController()
    let locationManager = CLLocationManager()
    var badgesBtn = UIButton()
    let badgesVC = BadgesViewController()
    
    var scrollView:UIScrollView! {
        get {
            return self.view as! UIScrollView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createChallenges()
        self.locationManager.requestWhenInUseAuthorization()
        
        self.badgesBtn = UIButton(frame: CGRectMake(10, 460, 44, 44))
        self.badgesBtn.backgroundColor = UIColor.yellowColor()
        self.badgesBtn.addTarget(self, action: "showBadges", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.badgesBtn)
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIScrollView(frame: bounds);
    }
    
    func createChallenges() {
        self.addChildViewController(self.grouphuggerVC)
        self.addChildViewController(self.masterscoutVC)
        self.addChildViewController(self.beerkingVC)
        
        self.view.addSubview(self.grouphuggerVC.view)
        self.view.addSubview(self.masterscoutVC.view)
        self.view.addSubview(self.beerkingVC.view)
        
        self.masterscoutVC.view.frame.origin.x = self.grouphuggerVC.view.frame.width
        self.beerkingVC.view.frame.origin.x = self.grouphuggerVC.view.frame.width + self.masterscoutVC.view.frame.origin.x
        
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSizeMake(self.beerkingVC.view.frame.width + self.beerkingVC.view.frame.origin.x, 0)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.badgesBtn.frame.origin.x = 10 + scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(self.grouphuggerVC.started && !CGRectIntersectsRect(scrollView.bounds, self.grouphuggerVC.view.frame)) {
            self.grouphuggerVC.stopChallenge()
        }
        if(self.masterscoutVC.started && !CGRectIntersectsRect(scrollView.bounds, self.masterscoutVC.view.frame)) {
            self.masterscoutVC.stopChallenge()
        }
        if(self.beerkingVC.started && !CGRectIntersectsRect(scrollView.bounds, self.beerkingVC.view.frame)) {
            self.beerkingVC.stopChallenge()
        }
    }
    
    func showBadges() {
        self.presentViewController(self.badgesVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
