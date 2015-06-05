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
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: Settings.currentDate)
        let seconds = components.hour * 60 * 60 + components.minute * 60 + components.second
        
        if(seconds > Settings.secondsEndDay) {
            println("'t Is gedaan!")
        }
        
        let grouphuggerDate:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("grouphuggerDate")
        let masterscoutDate:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("masterscoutDate")
        let beerkingDate:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("beerkingDate")
        if(grouphuggerDate != nil && calendar.isDate(grouphuggerDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.grouphuggerVC.detailView, toView: self.grouphuggerVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        if(masterscoutDate != nil && calendar.isDate(masterscoutDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.grouphuggerVC.detailView, toView: self.grouphuggerVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        if(beerkingDate != nil && calendar.isDate(beerkingDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.beerkingVC.detailView, toView: self.beerkingVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        
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
            self.grouphuggerVC.didFinishChallenge()
        }
        if(self.masterscoutVC.started && !CGRectIntersectsRect(scrollView.bounds, self.masterscoutVC.view.frame)) {
            self.masterscoutVC.didFinishChallenge()
        }
        if(self.beerkingVC.started && !CGRectIntersectsRect(scrollView.bounds, self.beerkingVC.view.frame)) {
            self.beerkingVC.didFinishChallenge()
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
