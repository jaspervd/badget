//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreLocation

class ChallengesViewController: UIViewController {
    
    let grouphuggerVC = GrouphuggerViewController()
    let masterscoutVC = MasterscoutViewController()
    let beerkingVC = BeerkingViewController()
    let locationManager = CLLocationManager()
    var badgesBtn = UIButton()
    let badgesVC = BadgesViewController()
    var grouphuggerBtn = UIButton()
    var masterscoutBtn = UIButton()
    var beerkingBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkTime()
        self.locationManager.requestWhenInUseAuthorization()
        self.title = "Uitdagingen"
        
        self.badgesBtn = UIButton(frame: CGRectMake(10, 440, 44, 44))
        self.badgesBtn.backgroundColor = UIColor.yellowColor()
        self.badgesBtn.addTarget(self, action: "showBadges", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.grouphuggerBtn = UIButton(frame: CGRectMake(10, 200, 300, 44))
        self.grouphuggerBtn.setTitle("Grouphugger", forState: .Normal)
        self.grouphuggerBtn.addTarget(self, action: "grouphuggerHandler", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.masterscoutBtn = UIButton(frame: CGRectMake(10, 244, 300, 44))
        self.masterscoutBtn.setTitle("Masterscout", forState: .Normal)
        self.masterscoutBtn.addTarget(self, action: "masterscoutHandler", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.beerkingBtn = UIButton(frame: CGRectMake(10, 288, 300, 44))
        self.beerkingBtn.setTitle("Beerking", forState: .Normal)
        self.beerkingBtn.addTarget(self, action: "beerkingHandler", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.badgesBtn)
        self.view.addSubview(self.grouphuggerBtn)
        self.view.addSubview(self.masterscoutBtn)
        self.view.addSubview(self.beerkingBtn)
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds);
    }
    
    func grouphuggerHandler() {
        self.navigationController?.pushViewController(self.grouphuggerVC, animated: true)
    }
    
    func masterscoutHandler() {
        self.navigationController?.pushViewController(self.masterscoutVC, animated: true)
    }
    
    func beerkingHandler() {
        self.navigationController?.pushViewController(self.beerkingVC, animated: true)
    }
    
    func checkTime() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: Settings.currentDate)
        let seconds = components.hour * 60 * 60 + components.minute * 60 + components.second
        
        if(seconds > Settings.secondsEndDay) {
            println("'t Is gedaan!")
        }
        
        let grouphuggerDate:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("grouphuggerDate")
        let masterscoutDate:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("masterscoutDate")
        let beerkingDate:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("beerkingDate")
        /*if(grouphuggerDate != nil && calendar.isDate(grouphuggerDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.grouphuggerVC.detailView, toView: self.grouphuggerVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        if(masterscoutDate != nil && calendar.isDate(masterscoutDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.grouphuggerVC.detailView, toView: self.grouphuggerVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        if(beerkingDate != nil && calendar.isDate(beerkingDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.beerkingVC.detailView, toView: self.beerkingVC.scoreView, duration: 0, options: nil, completion: nil)
        }*/
    }
    
    /*func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(self.grouphuggerVC.started && !CGRectIntersectsRect(scrollView.bounds, self.grouphuggerVC.view.frame)) {
            self.grouphuggerVC.didFinishChallenge()
        }
        if(self.masterscoutVC.started && !CGRectIntersectsRect(scrollView.bounds, self.masterscoutVC.view.frame)) {
            self.masterscoutVC.didFinishChallenge()
        }
        if(self.beerkingVC.started && !CGRectIntersectsRect(scrollView.bounds, self.beerkingVC.view.frame)) {
            self.beerkingVC.didFinishChallenge()
        }
    }*/
    
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
