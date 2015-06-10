//
//  BeerkingViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreMotion
import Alamofire

class BeerkingViewController: UIViewController, ChallengeProtocol {
    let motionManager = CMMotionManager()
    var detailView:BeerkingDetailView!
    var visualView:BeerkingVisualView!
    let device = UIDevice.currentDevice()
    var startTime = NSDate()
    var anglesArray:Array<Double> = []
    var started:Bool = false
    var descriptionText:String!
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
        self.detailView = BeerkingDetailView(frame: bounds)
        self.visualView = BeerkingVisualView(frame: bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        
        self.title = "Beerking"
        
        self.detailView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didStartChallenge() {
        UIView.transitionFromView(self.detailView, toView: self.visualView, duration: 1, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.anglesArray = []
        self.startTime = NSDate()
        self.started = true
        
        self.device.proximityMonitoringEnabled = true
        if(self.device.proximityMonitoringEnabled) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "proximityChanged:", name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        }
    }
    
    func startMotion() {
        if (self.motionManager.deviceMotionAvailable) {
            self.motionManager.deviceMotionUpdateInterval = 0.2;
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (data: CMDeviceMotion!, error: NSError!) -> Void in
                var quat:CMQuaternion = data.attitude.quaternion
                var pitch = atan2(2*(quat.y*quat.z + quat.w*quat.x), quat.w*quat.w - quat.x*quat.x - quat.y*quat.y + quat.z*quat.z) * 180/M_PI
                var roll = atan2(2*(quat.y*quat.w - quat.x*quat.z), 1 - 2*quat.y*quat.y - 2*quat.z*quat.z) * 180/M_PI
                var yaw = asin(2*(quat.x*quat.z - quat.w*quat.y)) * 180/M_PI
                
                var angle:Double = 0
                let minimum:Double = 10
                
                if(pitch > minimum || pitch < -minimum) {
                    angle = pitch
                } else if (roll > minimum || roll < -minimum) {
                    angle = roll
                } else if (yaw > minimum || yaw < -minimum) {
                    angle = yaw
                }
                
                if(angle < 0) {
                    angle += 180
                } else {
                    angle -= 180
                }
                
                self.visualView.angleText.text = String(format: "%.f", round(angle)) + "°"
                self.anglesArray.append(angle)
            })
        }
    }
    
    func didFinishChallenge() {
        self.device.proximityMonitoringEnabled = false
        self.started = false
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        
        var seconds = NSDate().timeIntervalSinceDate(self.startTime)
        
        if(self.anglesArray.count > 1) {
            self.anglesArray.removeLast() // last angle is when turning the device around
            var avg = (self.anglesArray as AnyObject).valueForKeyPath("@avg.self") as! Double
            var beerking = Beerking(angle: Int(avg), seconds: Int(round(seconds)))
            
            NSUserDefaults.standardUserDefaults().setObject(Settings.currentDate, forKey: "beerkingDate")
            NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(beerking), forKey: "beerkingLastScore")
            let parameters = [
                "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
                "day": Settings.currentDate,
                "angle": beerking.angle,
                "seconds": beerking.seconds
            ]
            Alamofire.request(.POST, Settings.apiUrl + "/beerking", parameters: parameters)
            
            let scoreVC = ScoreViewController(header: "Resultaat", feedback: "Je deed er \(beerking.seconds) seconden over en had een hellings gemiddelde van \(beerking.angle)!", badges: [])
            scoreVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(scoreVC, animated: true, completion: nil)
        }
        if(self.motionManager.deviceMotionActive) {
            self.motionManager.stopDeviceMotionUpdates()
        }
    }
    
    func proximityChanged(notification: NSNotification) {
        if(self.device.proximityState) {
            self.startMotion()
        } else {
            self.didFinishChallenge()
        }
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
