//
//  BadgesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 02/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreData

class BadgesViewController: UIViewController {
    
    var appDelegate:AppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! AppDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Badges"
        self.view.backgroundColor = Settings.bgColor
        
        let entity = NSEntityDescription.entityForName("Badge", inManagedObjectContext: self.appDelegate.managedObjectContext!)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
