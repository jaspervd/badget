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

class ChallengesViewController: UIViewController, CLLocationManagerDelegate, CircularScrollViewDataSource, CircularScrollViewDelegate {
    
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
            self.navigationController?.pushViewController(self.infoVC, animated: true)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSeenInfo")
        }
        
        createPasses()
        setupLocationManager()
        
        self.title = "Uitdagingen"
        
        let infoBtn = UIBarButtonItem(title: "Info", style: .Plain, target: self, action: "infoHandler")
        self.navigationItem.leftBarButtonItem = infoBtn
        
        let badgesBtn = UIBarButtonItem(title: "Badges", style: .Plain, target: self, action: "badgesHandler")
        self.navigationItem.rightBarButtonItem = badgesBtn
        
        checkTime()
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = ChallengesView(frame: bounds)
    }
    
    func createPasses() {
        self.challengeVCs = [ChallengeViewController(viewController: self.organisatorVC, navController: self.navigationController!, image: UIImage(named: "av")!, header: "Organisator"), ChallengeViewController(viewController: self.coordinatorVC, navController: self.navigationController!, image: UIImage(named: "av")!, header: "Coordinator"), ChallengeViewController(viewController: self.barmanVC, navController: self.navigationController!, image: UIImage(named: "av")!, header: "Barman")]
        //let challengesIntro = ["Overtuig zoveel mogelijk mensen om mee naar de Randstad stand te gaan en trek een toffe groepsfoto met elkaar!", "Vanaf de Randstad stand zal je een parcours moeten afleggen. Je moet het terrein van binnen en van buiten leren kennen.", "Ga naar de Randstad stand. Hier krijg je een plateau waar je jouw smartphone op moet leggen met het scherm naar beneden. Hierna zal je zo snel mogelijk en zo recht mogelijk de plateau moeten vervoeren doorheen een obstakelparcours."]
        
        println(Badge.loadPlist())
        
        self.numberOfChallenges = self.challengeVCs.count
        
        self.challengesView.circularScrollView.delegate = self
        self.challengesView.circularScrollView.dataSource = self
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
        if(inLocation && self.organisatorVC.isViewLoaded()) {
            self.organisatorVC.instructionView.btnContinue.enabled = true
        } else if(!inLocation && self.organisatorVC.isViewLoaded()) {
            self.organisatorVC.instructionView.btnContinue.enabled = false
        }
        if(inLocation && self.coordinatorVC.isViewLoaded()) {
            self.coordinatorVC.instructionView.btnContinue.enabled = true
        } else if(!inLocation && self.coordinatorVC.isViewLoaded()) {
            self.coordinatorVC.instructionView.btnContinue.enabled = false
        }
        if(inLocation && self.barmanVC.isViewLoaded()) {
            self.barmanVC.instructionView.btnContinue.enabled = true
        } else if(!inLocation && self.barmanVC.isViewLoaded()) {
            self.barmanVC.instructionView.btnContinue.enabled = false
        }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("entered region")
        if(self.organisatorVC.isViewLoaded()) {
            self.organisatorVC.instructionView.btnContinue.enabled = true
        }
        if(self.coordinatorVC.isViewLoaded()) {
            self.coordinatorVC.instructionView.btnContinue.enabled = true
        }
        if(self.barmanVC.isViewLoaded()) {
            self.barmanVC.instructionView.btnContinue.enabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("left region")
        if(self.organisatorVC.isViewLoaded()) {
            self.organisatorVC.instructionView.btnContinue.enabled = false
        }
        if(self.coordinatorVC.isViewLoaded()) {
            self.coordinatorVC.instructionView.btnContinue.enabled = false
        }
        if(self.barmanVC.isViewLoaded()) {
            self.barmanVC.instructionView.btnContinue.enabled = false
        }
    }
    
    func organisatorHandler() {
        if(self.organisatorVC.scoreVC == nil) {
            self.navigationController?.pushViewController(self.organisatorVC, animated: true)
        } else {
            self.navigationController?.pushViewController(self.organisatorVC.scoreVC, animated: true)
        }
    }
    
    func coordinatorHandler() {
        if(self.coordinatorVC.scoreVC == nil) {
            self.navigationController?.pushViewController(self.coordinatorVC, animated: true)
        } else {
            self.navigationController?.pushViewController(self.coordinatorVC.scoreVC, animated: true)
        }
    }
    
    func barmanHandler() {
        if(self.barmanVC.scoreVC == nil) {
            self.navigationController?.pushViewController(self.barmanVC, animated: true)
        } else {
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
                self.organisatorVC.setScore(organisator)
            }
        }
        
        if let coordinator = NSKeyedUnarchiver.unarchiveObjectWithFile(self.coordinatorVC.fileName) as? Coordinator {
            if(calendar.isDate(coordinator.date, inSameDayAsDate: Settings.currentDate)) {
                self.coordinatorVC.setScore(coordinator)
            }
        }
        
        if let barman = NSKeyedUnarchiver.unarchiveObjectWithFile(self.barmanVC.fileName) as? Barman {
            if(calendar.isDate(barman.date, inSameDayAsDate: Settings.currentDate)) {
                self.barmanVC.setScore(barman)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        for (index, challengeVC) in enumerate(challengeVCs) {
            if(CGRectIntersectsRect(scrollView.bounds, challengeVC.view.frame)) {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    challengeVC.view.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    challengeVC.view.transform = CGAffineTransformMakeScale(0.7, 0.7)
                }, completion: nil)
            }
        }
        if(self.organisatorVC.started && !CGRectIntersectsRect(scrollView.bounds, self.organisatorVC.view.frame)) {
            self.organisatorVC.didFinishChallenge()
        }
        if(self.coordinatorVC.started && !CGRectIntersectsRect(scrollView.bounds, self.coordinatorVC.view.frame)) {
            self.coordinatorVC.didFinishChallenge()
        }
        if(self.barmanVC.started && !CGRectIntersectsRect(scrollView.bounds, self.barmanVC.view.frame)) {
            self.barmanVC.didFinishChallenge()
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
