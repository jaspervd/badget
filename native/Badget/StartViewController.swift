//
//  StartViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import Alamofire

class StartViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var headVC:CharacterPartViewController!
    var bodyVC:CharacterPartViewController!
    var legsVC:CharacterPartViewController!
    
    var startView:StartView! {
        get {
            return self.view as! StartView
        }
    }
    
    let challengesVC = ChallengesViewController()
    var image:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var maleHeads = [UIImage(named: "av")!, UIImage(named: "av")!, UIImage(named: "av")!]
        var femaleHeads = [UIImage(named: "av")!, UIImage(named: "av")!, UIImage(named: "av")!]
        self.headVC = CharacterPartViewController(maleArray: maleHeads, femaleArray: femaleHeads)
        self.addChildViewController(self.headVC)
        
        var maleBodies = [UIImage(named: "av")!, UIImage(named: "av")!, UIImage(named: "av")!]
        var femaleBodies = [UIImage(named: "av")!, UIImage(named: "av")!, UIImage(named: "av")!]
        self.bodyVC = CharacterPartViewController(maleArray: maleBodies, femaleArray: femaleBodies)
        self.addChildViewController(self.bodyVC)
        
        var maleLegs = [UIImage(named: "av")!, UIImage(named: "av")!, UIImage(named: "av")!]
        var femaleLegs = [UIImage(named: "av")!, UIImage(named: "av")!, UIImage(named: "av")!]
        self.legsVC = CharacterPartViewController(maleArray: maleLegs, femaleArray: femaleLegs)
        self.addChildViewController(self.legsVC)
        
        self.view.addSubview(self.headVC.view)
        self.view.addSubview(self.bodyVC.view)
        self.view.addSubview(self.legsVC.view)
        
        self.bodyVC.view.frame.origin = CGPointMake(0, maleHeads[0].size.height)
        self.legsVC.view.frame.origin = CGPointMake(0, maleHeads[0].size.height + maleBodies[0].size.height)
        
        self.startView.btnContinue.addTarget(self, action: "continueClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.startView.genderSwitch.addTarget(self, action: "genderSwitched", forControlEvents: UIControlEvents.ValueChanged)
        self.startView.btnSave.addTarget(self, action: "saveClicked", forControlEvents: UIControlEvents.TouchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = StartView(frame:bounds)
        
        if(NSUserDefaults.standardUserDefaults().boolForKey("readCampaign")) {
            self.startView.showCredentials()
        }
    }
    
    func continueClicked() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "readCampaign")
        self.startView.showCredentials()
    }
    
    func genderSwitched() {
        self.headVC.switchActiveArray()
        self.bodyVC.switchActiveArray()
        self.legsVC.switchActiveArray()
    }
    
    func saveClicked() {
        var alertController = UIAlertController()
        var errors = false
        if(count(self.startView.inputName.text) < 1) {
            alertController = UIAlertController(title: "Foutje", message:
                "Gelieve je naam in te vullen.", preferredStyle: UIAlertControllerStyle.Alert)
            errors = true
        } else if(count(self.startView.inputEmail.text) < 1 || !isValidEmail(self.startView.inputEmail.text)) {
            alertController = UIAlertController(title: "Foutje", message:
                "Gelieve je e-mailadres in te vullen.", preferredStyle: UIAlertControllerStyle.Alert)
            errors = true
        }
        
        if(errors) {
            alertController.addAction(UIAlertAction(title: "Oké mama", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            saveUser()
            let navController = UINavigationController(rootViewController: ChallengesViewController())
            self.presentViewController(navController, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    func saveUser() {
        let fileUploader = FileUploader()
        
        //fileUploader.addFileData(UIImageJPEGRepresentation(data, 0.8), withName: "photo", withMimeType: "image/jpeg")
        fileUploader.setValue(self.startView.inputName.text, forParameter: "name")
        fileUploader.setValue(self.startView.inputEmail.text, forParameter: "email")
        var request = NSMutableURLRequest(URL: NSURL(string: Settings.apiUrl + "/users")!)
        request.HTTPMethod = "POST"
        fileUploader.uploadFile(request: request)?.responseJSON { (_, _, data, _) in
            let jsonData = JSON(data!)
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setBool(true, forKey: "loggedIn")
            userDefaults.setInteger(jsonData["id"].intValue, forKey: "userId")
            userDefaults.setObject(jsonData["name"].string, forKey: "name")
            userDefaults.setObject(jsonData["email"].string, forKey: "email")
            userDefaults.setObject(jsonData["photo_url"].string, forKey: "photoUrl")
        }
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
