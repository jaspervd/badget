//
//  InfoViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 10/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var infoView:InfoView! {
        get {
            return self.view as! InfoView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeHandler")
        swipeDown.direction = .Down
        
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = InfoView(frame: bounds);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeHandler() {
        self.navigationController?.popViewControllerAnimated(true)
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
