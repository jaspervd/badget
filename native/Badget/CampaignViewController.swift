//
//  CampaignViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 14/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CampaignViewController: UIViewController {
    
    var campaignView:CampaignView! {
        get {
            return self.view as! CampaignView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.campaignView.btnContinue.addTarget(self, action: "continueClicked", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func continueClicked() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "readCampaign")
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = CampaignView(frame: bounds)
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
