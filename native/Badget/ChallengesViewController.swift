//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreLocation

class ChallengesViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    
    let grouphuggerVC = GrouphuggerViewController()
    let masterscoutVC = MasterscoutViewController()
    let beerkingVC = BeerkingViewController()
    let locationManager = CLLocationManager()
    var badgesBtn = UIButton()
    let badgesVC = BadgesViewController()
    var grouphuggerBtn = UIButton()
    var masterscoutBtn = UIButton()
    var beerkingBtn = UIButton()
    var region:CLCircularRegion!
    
    var scrollView:UIScrollView! {
        get {
            return self.view as! UIScrollView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //checkTime()
        createPasses()
        setupLocationManager()
        
        self.title = "Uitdagingen"
        
        self.badgesBtn = UIButton(frame: CGRectMake(10, 440, 44, 44))
        self.badgesBtn.backgroundColor = UIColor.yellowColor()
        self.badgesBtn.addTarget(self, action: "showBadges", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(self.badgesBtn)
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIScrollView(frame: bounds);
    }
    
    func createPasses() {
        let challengesArray = [grouphuggerVC, masterscoutVC, beerkingVC]
        let challengesTitle = ["Grouphugger", "Masterscout", "Beerking"]
        let challengesIntro = ["Overtuig zoveel mogelijk mensen om mee naar de Randstad stand te gaan. Connecteer via Bluetooth met vrienden en eens bij de Randstad stand zal je score worden bepaald.", "Vanaf de Randstad stand zal je een parcours moeten afleggen. Je moet het terrein van binnen en van buiten leren kennen.", "Ga naar de Randstad stand. Hier krijg je een plateau waar je jouw smartphone op moet leggen met het scherm naar beneden. Hierna zal je zo snel mogelijk en zo recht mogelijk de plateau moeten vervoeren doorheen een obstakelparcours."]
        var xPos:CGFloat = 0
        for (index, challengeVC) in enumerate(challengesArray) {
            let challengeView = ChallengeView(frame: CGRectMake(xPos, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height), photo: UIImage(named: "av")!, title: challengesTitle[index], intro: challengesIntro[index])
            self.view.addSubview(challengeView)
            xPos += self.view.frame.width
            if(index != 1) {
                challengeView.transform = CGAffineTransformMakeScale(0.7, 0.7)
            }
            challengeView.btnContinue.tag = index
            challengeView.btnContinue.addTarget(self, action: "continueHandler:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        self.scrollView.contentOffset = CGPointMake(xPos / 3, 0)
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSizeMake(xPos, 0)
    }
    
    func continueHandler(sender: UIButton!) {
        switch(sender.tag) {
        case 0:
            grouphuggerHandler()
        case 1:
            masterscoutHandler()
        case 2:
            beerkingHandler()
        default:
            masterscoutHandler()
        }
    }
    
    func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1
        if (CLLocationManager.authorizationStatus() == .NotDetermined) {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            self.region = CLCircularRegion(center: Settings.randstadCoords, radius: 10, identifier: "Randstad Stand")
            manager.startMonitoringForRegion(region)
        } else {
            println("Not authorized :(")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if(self.region.containsCoordinate(newLocation.coordinate)) {
            println("already in region")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        let alertController = UIAlertController(title: "Great Success", message:
            "Aww yiss", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Jeppep", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        let alertController = UIAlertController(title: "Oh...", message:
            "Please come back :(?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "I don't know man...", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
        if(grouphuggerDate != nil && calendar.isDate(grouphuggerDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.grouphuggerVC.detailView, toView: self.grouphuggerVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        if(masterscoutDate != nil && calendar.isDate(masterscoutDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.grouphuggerVC.detailView, toView: self.grouphuggerVC.scoreView, duration: 0, options: nil, completion: nil)
        }
        if(beerkingDate != nil && calendar.isDate(beerkingDate as! NSDate, inSameDayAsDate: Settings.currentDate)) {
            UIView.transitionFromView(self.beerkingVC.detailView, toView: self.beerkingVC.scoreView, duration: 0, options: nil, completion: nil)
        }
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
