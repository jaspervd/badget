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

class MasterscoutViewController: UIViewController, ChallengeProtocol {
    var detailView:MasterscoutDetailView!
    var visualView:MasterscoutVisualView!
    var scoreView:MasterscoutScoreView!
    var started:Bool = false
    var timer:NSTimer = NSTimer()
    var milliseconds:CGFloat = 0
    var locations:Array<CLRegion> = []
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
        self.detailView = MasterscoutDetailView(frame: bounds)
        self.visualView = MasterscoutVisualView(frame: bounds)
        self.scoreView = MasterscoutScoreView(frame: bounds)
        
        createLocations()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        
        self.detailView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func createLocations() {
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Main Stage"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Club"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Wablief?!"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Picknick Area"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Castello"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Petit Bazar"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Trashure Island"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Salon Fou"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Marquee"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "The Shelter"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Le Bois Batterie"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Chill Out"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Boiler Room"))
        self.locations.append(CLCircularRegion(center: CLLocationCoordinate2DMake(50, 4), radius: 50, identifier: "Dance Hall"))
    }
    
    func didStartChallenge() {
        UIView.transitionFromView(self.detailView, toView: self.visualView, duration: 1, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerHandler", userInfo: nil, repeats: true)
        self.started = true
            
        var loc = self.getRandomLocation()
        self.visualView.instructionText.text = "Ga naar de \(loc.identifier)"
    }
    
    func getRandomLocation() -> CLRegion {
        let index:Int = Int(arc4random_uniform(UInt32(self.locations.count)))
        let key = self.locations[index]
        self.locations.removeAtIndex(index)
        return key
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
        self.visualView.timerText.text = "\(formatter.stringFromNumber(hours)!):\(formatter.stringFromNumber(minutes)!):\(formatter.stringFromNumber(seconds)!).\(formatter.stringFromNumber(ms)!)"
    }
    
    func didFinishChallenge() {
        UIView.transitionFromView(self.visualView, toView: self.scoreView, duration: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.started = false
        var masterscout = Masterscout(time: self.visualView.timerText.text!, distance: 420)
        NSUserDefaults.standardUserDefaults().setObject(Settings.currentDate, forKey: "masterscoutDate")
        NSUserDefaults.standardUserDefaults().setObject(masterscout, forKey: "masterscoutLastScore")
        let parameters = [
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
            "day": Settings.currentDate,
            "time": masterscout.time,
            "distance": masterscout.distance
        ]
        self.scoreView.timerText.text = masterscout.time
        Alamofire.request(.POST, Settings.apiUrl + "/masterscout", parameters: parameters)
        timer.invalidate()
        self.milliseconds = 0
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
