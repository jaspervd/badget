//
//  MasterscoutViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import CoreLocation

class MasterscoutViewController: UIViewController, ChallengeProtocol, CLLocationManagerDelegate {
    var instructionView:InstructionView!
    var started:Bool = false
    var timer:NSTimer = NSTimer()
    var milliseconds:CGFloat = 0
    var locations:Array<CLRegion> = []
    let locationManager = CLLocationManager()
    var distance:Double = 0
    var locationsVisited:Int = 0
    
    var masterscoutView:MasterscoutView! {
        get {
            return self.view as! MasterscoutView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = MasterscoutView(frame: bounds)
        self.instructionView = InstructionView(frame: bounds)
        
        createLocations()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.instructionView)
        
        self.title = "Masterscout"
        
        self.instructionView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func createLocations() {
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 60, identifier: "Main Stage"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 40, identifier: "Club"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 20, identifier: "Wablief?!"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 20, identifier: "Picknick Area"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 30, identifier: "Castello"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Petit Bazar"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 30, identifier: "Trashure Island"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 10, identifier: "Salon Fou"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 40, identifier: "Marquee"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 30, identifier: "The Shelter"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 20, identifier: "Le Bois Batterie"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 30, identifier: "Chill Out"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 40, identifier: "Boiler Room"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 35, identifier: "Dance Hall"))
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1
    }
    
    func didStartChallenge() {
        self.instructionView.removeFromSuperview()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerHandler", userInfo: nil, repeats: true)
        self.started = true
            
        var loc = self.getRandomLocation()
        self.locationManager.startUpdatingLocation()
        self.locationManager.startMonitoringForRegion(loc)
        self.instructionView.instructionTextView.text = "Ga naar de \(loc.identifier)"
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
            self.instructionView.instructionTextView.text = "Ga naar de \(loc.identifier)"
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
        self.masterscoutView.timerText.text = "\(formatter.stringFromNumber(hours)!):\(formatter.stringFromNumber(minutes)!):\(formatter.stringFromNumber(seconds)!).\(formatter.stringFromNumber(ms)!)"
    }
    
    func didFinishChallenge() {
        self.started = false
        var masterscout = Masterscout(time: self.masterscoutView.timerText.text!, distance: self.distance)
        NSUserDefaults.standardUserDefaults().setObject(Settings.currentDate, forKey: "masterscoutDate")
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(masterscout), forKey: "masterscoutLastScore")
        let parameters = [
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
            "day": Settings.currentDate,
            "time": masterscout.time,
            "distance": masterscout.distance
        ]
        Alamofire.request(.POST, Settings.apiUrl + "/masterscout", parameters: parameters)
        timer.invalidate()
        self.milliseconds = 0
        
        let scoreVC = ScoreViewController(header: "Resultaat", feedback: "Je legde in \(masterscout.time) een afstand van \(masterscout.distance)m af!", badges: [])
        scoreVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(scoreVC, animated: true, completion: nil)
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
