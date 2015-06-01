//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit

class ChallengesViewController: UIViewController, UIScrollViewDelegate {
    
    let grouphuggerVC = GrouphuggerViewController()
    let masterscoutVC = MasterscoutViewController()
    let beerkingVC = BeerkingViewController()
    let device = UIDevice.currentDevice()
    let locationManager = CLLocationManager()
    
    var scrollView:UIScrollView! {
        get {
            return self.view as! UIScrollView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createChallenges()
        
        self.device.proximityMonitoringEnabled = true
        if(self.device.proximityMonitoringEnabled) {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "proximityChanged:", name: "UIDeviceProximityStateDidChangeNotification", object: nil)
        }
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIScrollView(frame: bounds);
    }
    
    func createChallenges() {
        self.addChildViewController(self.grouphuggerVC)
        self.addChildViewController(self.masterscoutVC)
        self.addChildViewController(self.beerkingVC)
        
        self.view.addSubview(self.grouphuggerVC.view)
        self.view.addSubview(self.masterscoutVC.view)
        self.view.addSubview(self.beerkingVC.view)
        
        var xPos:CGFloat = 0
        for view in self.view.subviews {
            println(view)
            //view.frame = CGRectMake(xPos, 0, self.view.frame.width, self.view.frame.height)
            xPos += view.frame.width
        }
        
        self.masterscoutVC.view.frame.origin.x = 320
        self.beerkingVC.view.frame.origin.x = 640
        
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSizeMake(xPos, 0)
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //if(!CGRectIntersectsRect(scrollView.bounds, self.masterscoutVC.view.frame)) {
    }
    
    func proximityChanged(notification: NSNotification) {
        println("Proximity changed", self.device.proximityState)
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
