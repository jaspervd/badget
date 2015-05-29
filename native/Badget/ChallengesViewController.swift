//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreMotion
import MapKit

class ChallengesViewController: UIViewController, UIScrollViewDelegate, MKMapViewDelegate {
    
    let motionManager = CMMotionManager()
    let device = UIDevice.currentDevice()
    var motionLastRoll:Double! = 0
    let locationManager = CLLocationManager()
    
    var sliderView:SliderView! {
        get {
            return self.view as! SliderView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sliderView.scrollView.delegate = self
        self.device.proximityMonitoringEnabled = true
        if(self.device.proximityMonitoringEnabled) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "proximityChanged:", name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        }
        
        self.locationManager.requestWhenInUseAuthorization()
        self.sliderView.grouphuggerView.btnContinue.addTarget(self, action: "grouphuggerChallenge", forControlEvents: UIControlEvents.TouchUpInside)
        self.sliderView.masterscoutView.btnContinue.addTarget(self, action: "masterscoutChallenge", forControlEvents: UIControlEvents.TouchUpInside)
        self.sliderView.beerkingView.btnContinue.addTarget(self, action: "beerkingChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(!CGRectIntersectsRect(scrollView.bounds, self.sliderView.masterscoutView.frame)) {
            self.sliderView.masterscoutView.showStart()
        }
        
        if(!CGRectIntersectsRect(scrollView.bounds, self.sliderView.beerkingView.frame)) {
            self.sliderView.beerkingView.showStart()
            if(self.motionManager.deviceMotionActive) {
                self.motionManager.stopDeviceMotionUpdates()
            }
        }
    }
    
    func proximityChanged(notification: NSNotification) {
        println("Proximity changed", self.device.proximityState)
        
    }
    
    func grouphuggerChallenge() {
        
    }
    
    func masterscoutChallenge() {
        self.sliderView.masterscoutView.showChallenge()
    }
    
    func beerkingChallenge() {
        self.sliderView.beerkingView.showChallenge()
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
                
                self.sliderView.beerkingView.angleText.text = String(format: "%.f", round(angle)) + "°"
            })
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = SliderView(frame:bounds);
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
