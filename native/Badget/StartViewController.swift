//
//  StartViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var startView:StartView! {
        get {
            return self.view as! StartView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startView.btnContinue.addTarget(self, action: "continueClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.startView.btnPhoto.addTarget(self, action: "photoClicked", forControlEvents: UIControlEvents.TouchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = StartView(frame:bounds)
    }
    
    func continueClicked() {
        println("[StartViewController] Continue")
        self.startView.showCredentials()
    }
    
    func photoClicked() {
        // to camera roll
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
