//
//  CoordinatorViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import CoreLocation

class CoordinatorViewController: UIViewController, CLLocationManagerDelegate {
    var started:Bool = false
    var timer:NSTimer = NSTimer()
    var countdown:NSTimer = NSTimer()
    var countdownTime = 5
    var milliseconds:CGFloat = 0
    var locations:Array<CLRegion> = []
    let locationManager = CLLocationManager()
    var distance:Double = 0
    var locationsVisited:Int = 0
    var scoreVC:ScoreViewController!
    var fileName:String {
        get {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            return documentsPath.stringByAppendingPathComponent("coordinator.challenge")
        }
    }
    
    var coordinatorView:CoordinatorView! {
        get {
            return self.view as! CoordinatorView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = CoordinatorView(frame: bounds)
        
        createLocations()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countdown = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countdownHandler", userInfo: nil, repeats: true)
    }
    
    func countdownHandler() {
        self.countdownTime--
        self.coordinatorView.countdownText.transform = CGAffineTransformMakeScale(1, 1)
        self.coordinatorView.countdownText.alpha = 1
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.coordinatorView.countdownText.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.coordinatorView.countdownText.alpha = 0
        })
        self.coordinatorView.countdownText.text = "\(self.countdownTime)"
        if(countdownTime < 0) {
            self.coordinatorView.startChallenge()
            self.didStartChallenge()
            self.countdown.invalidate()
        }
    }
    
    func createLocations() {
        let regions = Region.loadPlist()
        for region in regions {
            self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(region.latitude, region.longitude), radius: region.radius, identifier: region.name))
        }
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1
    }
    
    func didStartChallenge() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerHandler", userInfo: nil, repeats: true)
        self.started = true
            
        var loc = self.getRandomLocation()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringForRegion(loc)
        self.coordinatorView.locationText.text = "\(loc.identifier)"
    }
    
    func getRandomLocation() -> CLRegion {
        let index:Int = Int(arc4random_uniform(UInt32(self.locations.count)))
        let key = self.locations[index]
        self.locations.removeAtIndex(index)
        return key
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        self.distance += newLocation.distanceFromLocation(oldLocation)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        self.locationManager.stopMonitoringForRegion(region)
        self.locationsVisited++
        
        if(self.locationsVisited < 5) { // if user hasn't visited 5 locations yet
            var loc = getRandomLocation()
            self.locationManager.startMonitoringForRegion(loc)
            self.coordinatorView.locationText.text = "\(loc.identifier)"
        } else {
            didFinishChallenge()
        }
    }
    
    func timerHandler() {
        self.milliseconds += 0.01
        var formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        var sec = Int(self.milliseconds)
        var hours:Int = sec / (60 * 60)
        var minutes:Int = sec / 60 - hours * 60
        var seconds:Int = sec - (minutes * 60 + hours * 60)
        var ms = Int((self.milliseconds - CGFloat(sec)) * 100)
        self.coordinatorView.timerText.text = "\(formatter.stringFromNumber(hours)!):\(formatter.stringFromNumber(minutes)!):\(formatter.stringFromNumber(seconds)!).\(formatter.stringFromNumber(ms)!)"
    }
    
    func setScore(coordinator: Coordinator) {
        self.scoreVC = ScoreViewController(header: "Resultaat", feedback: "Je legde in \(coordinator.time) een afstand van \(coordinator.distance)m af!", badge: coordinator.badge)
    }
    
    func didFinishChallenge() {
        self.started = false
        
        var badge = Badge()
        let badges = Badge.loadPlist()
        if(self.milliseconds < 120000 && self.distance < 1000) { // if faster than 20 min + distance was less than 1km
            badge = badges[5]
        } else if(self.milliseconds > 120000 && self.distance < 1000) { // if slower than 20 min + distance was less than 1km
            badge = badges[6]
        } else if(self.milliseconds < 120000 && self.distance > 1000) { // if faster than 20 min + distance was larger than 1km
            badge = badges[7]
        } else if(self.milliseconds > 120000 && self.distance > 1000) {
            badge = badges[8]
        }
        
        
        var coordinator = Coordinator(date: Settings.currentDate, time: self.coordinatorView.timerText.text!, distance: self.distance, badge: badge)
        if(NSKeyedArchiver.archiveRootObject(coordinator, toFile: self.fileName)) {
            badge.save()
            coordinator.save()
        
            setScore(coordinator)
            self.navigationController?.pushViewController(scoreVC, animated: true)
        }
        
        self.milliseconds = 0
        timer.invalidate()
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
