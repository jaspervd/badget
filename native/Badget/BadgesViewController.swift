//
//  BadgesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 02/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Badges"
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
