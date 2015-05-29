//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreMotion

class ChallengesViewController: UIViewController, UIScrollViewDelegate {
    
    let motionManager = CMMotionManager()
    let device = UIDevice.currentDevice()
    var motionLastRoll:Double! = 0
    
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
        
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // if beerkingView is in view
        if(CGRectIntersectsRect(scrollView.bounds, self.sliderView.beerkingView.frame)) {
            beerkingVisible()
        }
    }
    
    func proximityChanged(notification: NSNotification) {
        println("Proximity changed", self.device.proximityState)
    }
    
    func beerkingVisible() {
        if (self.motionManager.gyroAvailable) {
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
                
                self.sliderView.beerkingView.angleText.text = String(stringInterpolationSegment: round(angle)) + "°"
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
