//
//  ChallengesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreLocation
import CircularScrollView

class ChallengesViewController: UIViewController, CLLocationManagerDelegate, CircularScrollViewDataSource, CircularScrollViewDelegate, ChallengeDelegate {
    
    let organisatorVC = OrganisatorViewController()
    let coordinatorVC = CoordinatorViewController()
    let barmanVC = BarmanViewController()
    let locationManager = CLLocationManager()
    var badgesBtn = UIBarButtonItem()
    let infoVC = InfoViewController()
    let badgesVC = BadgesViewController()
    var region:CLCircularRegion!
    var challengeVCs:Array<ChallengeViewController> = []
    var numberOfChallenges:Int = 0
    
    var challengesView:ChallengesView! {
        get {
            return self.view as! ChallengesView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("hasSeenInfo")) {
            self.navigationController?.pushViewController(self.infoVC, animated: false)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenInfo")
        }
        
        createPasses()
        setupLocationManager()
        self.title = ""
        
        let infoBtn = UIBarButtonItem(image: UIImage(named: "infobtn"), style: .Plain, target: self, action: "infoHandler")
        infoBtn.image = infoBtn.image?.imageWithRenderingMode(.AlwaysOriginal)
        self.navigationItem.leftBarButtonItem = infoBtn
        
        let badgesBtn = UIBarButtonItem(title: "Badges", style: .Plain, target: self, action: "badgesHandler")
        self.navigationItem.rightBarButtonItem = badgesBtn
        
        let backBtn = UIImage(named: "backbtn")!.imageWithRenderingMode(.AlwaysOriginal)
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.backIndicatorImage = backBtn
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backBtn
        
        self.challengesView.leftBtn.addTarget(self, action: "leftBtnHandler", forControlEvents: UIControlEvents.TouchUpInside)
        self.challengesView.rightBtn.addTarget(self, action: "rightBtnHandler", forControlEvents: UIControlEvents.TouchUpInside)
        
        checkTime()
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = ChallengesView(frame: bounds)
    }
    
    func leftBtnHandler() {
        var index = self.numberOfChallenges - 1
        if(self.challengesView.circularScrollView.currentPage() > 0) {
            index = self.challengesView.circularScrollView.currentPage() - 1
        }
        self.challengesView.circularScrollView.moveToPage(index, animated: true)
    }
    
    func rightBtnHandler() {
        var index = 0
        if(self.challengesView.circularScrollView.currentPage() < (self.numberOfChallenges - 1)) {
            index = self.challengesView.circularScrollView.currentPage() + 1
        }
        self.challengesView.circularScrollView.moveToPage(index, animated: true)
    }
    
    func createPasses() {
        let organisatorChallenge = ChallengeViewController(viewController: self.organisatorVC, navController: self.navigationController!, header: "organisator")
        organisatorChallenge.delegate = self
        let coordinatorChallenge = ChallengeViewController(viewController: self.coordinatorVC, navController: self.navigationController!, header: "coordinator")
        coordinatorChallenge.delegate = self
        let barmanChallenge = ChallengeViewController(viewController: self.barmanVC, navController: self.navigationController!, header: "barman")
        barmanChallenge.delegate = self
        self.challengeVCs = [organisatorChallenge, coordinatorChallenge, barmanChallenge]
        
        self.numberOfChallenges = self.challengeVCs.count
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.challengesView.circularScrollView.delegate = self
        self.challengesView.circularScrollView.dataSource = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "organisatorHandler", name: "organisatorDidFinish", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "coordinatorHandler", name: "coordinatorDidFinish", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "barmanHandler", name: "barmanDidFinish", object: nil)
    }
    
    func willShowResult(challenge: ChallengeViewController) {
        switch challenge.header {
        case "organisator":
            organisatorHandler()
            
        case "coordinator":
            coordinatorHandler()
            
        case "barman":
            barmanHandler()
            
        default:
            self.navigationController?.pushViewController(challenge.viewController, animated: true)
        }
    }
    
    func numberOfPagesInCircularScrollView(#scroll: CircularScrollView!) -> Int! {
        return self.numberOfChallenges
    }
    
    func circularScrollView(#scroll: CircularScrollView!, viewControllerAtIndex index: Int!) -> UIViewController! {
        return self.challengeVCs[index]
    }
    
    func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1
        if (CLLocationManager.authorizationStatus() == .NotDetermined) {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            self.region = CLCircularRegion(center: Settings.randstadCoords, radius: 10, identifier: "Randstad Stand")
            manager.startMonitoringForRegion(region)
        } else {
            println("Not authorized :(")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        let inLocation = self.region.containsCoordinate(newLocation.coordinate)
        
        for challengeVC in challengeVCs {
            challengeVC.challengeView.btnContinue.enabled = inLocation
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        for challengeVC in challengeVCs {
            challengeVC.challengeView.btnContinue.enabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        for challengeVC in challengeVCs {
            challengeVC.challengeView.btnContinue.enabled = false
        }
    }
    
    func organisatorHandler() {
        if(self.organisatorVC.scoreVC == nil) {
            self.navigationController?.pushViewController(self.organisatorVC, animated: true)
        } else {
            self.challengeVCs[0].setDone()
            self.navigationController?.popViewControllerAnimated(false)
            self.navigationController?.pushViewController(self.organisatorVC.scoreVC, animated: true)
        }
    }
    
    func coordinatorHandler() {
        if(self.coordinatorVC.scoreVC == nil) {
            self.navigationController?.pushViewController(self.coordinatorVC, animated: true)
        } else {
            self.challengeVCs[1].setDone()
            self.navigationController?.popViewControllerAnimated(false)
            self.navigationController?.pushViewController(self.coordinatorVC.scoreVC, animated: true)
        }
    }
    
    func barmanHandler() {
        if(self.barmanVC.scoreVC == nil) {
            self.navigationController?.pushViewController(self.barmanVC, animated: true)
        } else {
            self.challengeVCs[2].setDone()
            self.navigationController?.popViewControllerAnimated(false)
            self.navigationController?.pushViewController(self.barmanVC.scoreVC, animated: true)
        }
    }
    
    func checkTime() {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: Settings.currentDate)
        let seconds = components.hour * 60 * 60 + components.minute * 60 + components.second
        
        if(seconds > Settings.secondsEndDay) {
            println("'t Is gedaan!")
        }
        
        if let organisator = NSKeyedUnarchiver.unarchiveObjectWithFile(self.organisatorVC.fileName) as? Organisator {
            if(calendar.isDate(organisator.date, inSameDayAsDate: Settings.currentDate)) {
                self.challengeVCs[0].setDone()
                self.organisatorVC.setScore(organisator)
            }
        }
        
        if let coordinator = NSKeyedUnarchiver.unarchiveObjectWithFile(self.coordinatorVC.fileName) as? Coordinator {
            if(calendar.isDate(coordinator.date, inSameDayAsDate: Settings.currentDate)) {
                self.challengeVCs[1].setDone()
                self.coordinatorVC.setScore(coordinator)
            }
        }
        
        if let barman = NSKeyedUnarchiver.unarchiveObjectWithFile(self.barmanVC.fileName) as? Barman {
            if(calendar.isDate(barman.date, inSameDayAsDate: Settings.currentDate)) {
                self.challengeVCs[2].setDone()
                self.barmanVC.setScore(barman)
            }
        }
    }
    
    func infoHandler() {
        self.navigationController?.pushViewController(self.infoVC, animated: true)
    }
    
    func badgesHandler() {
        self.navigationController?.pushViewController(self.badgesVC, animated: true)
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
