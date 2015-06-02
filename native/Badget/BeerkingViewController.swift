//
//  BeerkingViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreMotion

class BeerkingViewController: UIViewController, ChallengeProtocol {
    let motionManager = CMMotionManager()
    let detailView = UIView()
    let device = UIDevice.currentDevice()
    var startTime = NSDate()
    var anglesArray:Array<Double> = []
    
    var beerkingView:BeerkingView! {
        get {
            return self.view as! BeerkingView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = BeerkingView(frame: bounds)
        self.detailView.frame = bounds
        self.detailView.backgroundColor = UIColor.whiteColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        self.detailView.hidden = true
        
        self.beerkingView.btnContinue.addTarget(self, action: "startChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func startChallenge() {
        self.anglesArray = []
        self.startTime = NSDate()
        self.detailView.hidden = false
        self.detailView.addSubview(self.beerkingView.angleText)
        
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
                
                self.beerkingView.angleText.text = String(format: "%.f", round(angle)) + "°"
                self.anglesArray.append(angle)
            })
        }
    }
    
    func stopChallenge() {
        self.device.proximityMonitoringEnabled = false
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        self.detailView.hidden = true
        
        var seconds = NSDate().timeIntervalSinceDate(self.startTime)
        println("Seconds: \(round(seconds))")
        
        if(self.anglesArray.count > 0) {
            var avg = (self.anglesArray as AnyObject).valueForKeyPath("@avg.self") as! Double
            println(avg)
        }
        if(self.motionManager.deviceMotionActive) {
            self.motionManager.stopDeviceMotionUpdates()
        }
    }
    
    func proximityChanged(notification: NSNotification) {
        println("Proximity changed", self.device.proximityState)
        if(self.device.proximityState) {
            self.startMotion()
        } else {
            self.stopChallenge()
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
