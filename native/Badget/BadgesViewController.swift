//
//  BadgesViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 02/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class BadgesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Badges"

        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeHandler")
        swipeDown.direction = .Down
        
        self.view.addGestureRecognizer(swipeDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func swipeHandler() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
