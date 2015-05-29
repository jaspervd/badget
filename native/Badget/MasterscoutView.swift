//
//  MasterscoutView.swift
//  Badget
//
//  Created by Jasper Van Damme on 29/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit

class MasterscoutView: UIView {
    
    let btnContinue:UIButton
    let mapView:MKMapView
    
    override init(frame: CGRect) {
        self.btnContinue = UIButton(frame: CGRectMake(10, 440, 300, 40))
        self.mapView = MKMapView(frame: CGRectMake(0, 0, frame.width, frame.height))
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.redColor()
        
        self.btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        self.mapView.hidden = true
        
        self.addSubview(self.btnContinue)
        self.addSubview(self.mapView)
    }
    
    func showChallenge() {
        self.btnContinue.hidden = true
        
        self.mapView.hidden = false
        initMap()
    }
    
    func initMap() {
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
        
        self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 500, 500), animated: true)
    }
    
    func showStart() {
        self.btnContinue.hidden = false
        
        self.mapView.hidden = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
