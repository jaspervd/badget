//
//  MasterscoutViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit

class MasterscoutViewController: UIViewController, ChallengeProtocol, MKMapViewDelegate {
    let detailView = MKMapView()
    
    var masterscoutView:MasterscoutView! {
        get {
            return self.view as! MasterscoutView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = MasterscoutView(frame: bounds)
        self.detailView.frame = bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        self.detailView.hidden = true
        self.detailView.delegate = self
        
        self.masterscoutView.btnContinue.addTarget(self, action: "startChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func startChallenge() {
        self.detailView.showsUserLocation = true
        self.detailView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
            
        self.detailView.setRegion(MKCoordinateRegionMakeWithDistance(self.detailView.userLocation.coordinate, 500, 500), animated: true)
    }
    
    func stopChallenge() {
        self.detailView.hidden = true
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
