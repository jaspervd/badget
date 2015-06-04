//
//  MasterscoutViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit

class MasterscoutViewController: UIViewController, ChallengeProtocol {
    var detailView:MasterscoutDetailView!
    var visualView:MasterscoutVisualView!
    var scoreView:MasterscoutScoreView!
    var started:Bool = false
    var timer:NSTimer = NSTimer()
    var milliseconds:CGFloat = 0
    var locations = Dictionary<String, Int>() // CLLocationCoordinate2D
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
        self.detailView = MasterscoutDetailView(frame: bounds)
        self.visualView = MasterscoutVisualView(frame: bounds)
        self.scoreView = MasterscoutScoreView(frame: bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        
        self.detailView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didStartChallenge() {
        UIView.transitionFromView(self.detailView, toView: self.visualView, duration: 1, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "timerHandler", userInfo: nil, repeats: true)
        self.started = true
            
        self.locations = ["Mainstage": 13, "Dance Hall": 4, "Boiler Room": 6, "Chateau": 3, "Marquee": 80, "Petit Bazar": 43, "Arabian Tea Site": 2, "Salon Fou": 73, "The Shelter": 56, "WC naast de Chateau": 30]
            
        var loc = self.getRandomLocation()
        self.visualView.instructionText.text = "Ga naar de \(loc)"
    }
    
    func getRandomLocation() -> String {
        let index:Int = Int(arc4random_uniform(UInt32(self.locations.count)))
        let key = Array(self.locations.keys)[index]
        self.locations.removeValueForKey(key)
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
        self.scoreView.timerText.text = self.visualView.timerText.text
        var masterscout = Masterscout(time: Int(self.milliseconds * 100))
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
