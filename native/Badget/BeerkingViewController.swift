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
    
    var beerkingView:BeerkingView! {
        get {
            return self.view as! BeerkingView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = BeerkingView(frame: bounds)
        self.detailView.frame = bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        self.detailView.hidden = true
        
        self.beerkingView.btnContinue.addTarget(self, action: "startChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func startChallenge() {
        self.detailView.addSubview(self.beerkingView.angleText)
        self.detailView.hidden = false
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
            })
        }
    }
    
    func stopChallenge() {
        self.detailView.hidden = true
        if(self.motionManager.deviceMotionActive) {
            self.motionManager.stopDeviceMotionUpdates()
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
