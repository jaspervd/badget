//
//  registerViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var headVC:CharacterPartViewController!
    var bodyVC:CharacterPartViewController!
    var legsVC:CharacterPartViewController!
    var gender = "m"
    
    var registerView:RegisterView! {
        get {
            return self.view as! RegisterView
        }
    }
    
    let challengesVC = ChallengesViewController()
    var image:UIImage?
    var kbHeight:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var maleHeads = [UIImage(named: "avatarhead1")!, UIImage(named: "avatarhead2")!, UIImage(named: "avatarhead3")!, UIImage(named: "avatarhead4")!, UIImage(named: "avatarhead5")!, UIImage(named: "avatarhead6")!]
        //var femaleHeads = [UIImage(named: "avatarhead")!, UIImage(named: "avatarhead")!, UIImage(named: "avatarhead")!]
        self.headVC = CharacterPartViewController(maleArray: maleHeads, femaleArray: maleHeads)
        self.addChildViewController(self.headVC)
        
        var maleBodies = [UIImage(named: "avatartorso1")!, UIImage(named: "avatartorso2")!, UIImage(named: "avatartorso3")!, UIImage(named: "avatartorso4")!, UIImage(named: "avatartorso5")!, UIImage(named: "avatartorso6")!]
        //var femaleBodies = [UIImage(named: "avatartorso")!, UIImage(named: "avatartorso")!, UIImage(named: "avatartorso")!]
        self.bodyVC = CharacterPartViewController(maleArray: maleBodies, femaleArray: maleBodies)
        self.addChildViewController(self.bodyVC)
        
        var maleLegs = [UIImage(named: "avatarlegs1")!, UIImage(named: "avatarlegs2")!, UIImage(named: "avatarlegs3")!, UIImage(named: "avatarlegs4")!, UIImage(named: "avatarlegs5")!, UIImage(named: "avatarlegs6")!]
        //var femaleLegs = [UIImage(named: "avatarlegs")!, UIImage(named: "avatarlegs")!, UIImage(named: "avatarlegs")!]
        self.legsVC = CharacterPartViewController(maleArray: maleLegs, femaleArray: maleLegs)
        self.addChildViewController(self.legsVC)
        
        self.headVC.view.frame.origin = CGPointMake(0, 30)
        self.bodyVC.view.frame.origin = CGPointMake(0, maleHeads[0].size.height + 25)
        self.legsVC.view.frame.origin = CGPointMake(0, maleHeads[0].size.height + maleBodies[0].size.height + 22)
        
        self.registerView.characterView.addSubview(self.bodyVC.view)
        self.registerView.characterView.addSubview(self.legsVC.view)
        self.registerView.characterView.addSubview(self.headVC.view)
        
        self.registerView.genderSwitch.addTarget(self, action: "switchHandler", forControlEvents: .TouchUpInside)
        self.registerView.maleBtn.addTarget(self, action: "switchMale", forControlEvents: .TouchUpInside)
        self.registerView.femaleBtn.addTarget(self, action: "switchFemale", forControlEvents: .TouchUpInside)
        self.registerView.btnSave.addTarget(self, action: "saveClicked", forControlEvents: .TouchUpInside)
        
        self.registerView.inputName.delegate = self
        self.registerView.inputEmail.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func dismissKeyboard() {
        self.registerView.inputName.resignFirstResponder()
        self.registerView.inputEmail.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.kbHeight = keyboardSize.height
                moveContent(true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        moveContent(false)
    }
    
    func moveContent(up: Bool) {
        var movement = (up ? -self.kbHeight : self.kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = RegisterView(frame: bounds)
    }
    
    func switchHandler() {
        self.registerView.genderSwitch.setOn(!self.registerView.genderSwitch.on, animated: true)
        genderSwitched()
    }
    
    func switchMale() {
        self.registerView.genderSwitch.setOn(true, animated: true)
        genderSwitched()
    }
    
    func switchFemale() {
        self.registerView.genderSwitch.setOn(false, animated: true)
        genderSwitched()
    }
    
    func genderSwitched() {
        self.registerView.maleBtn.selected = self.registerView.genderSwitch.on
        self.registerView.femaleBtn.selected = !self.registerView.genderSwitch.on
        self.gender = (self.registerView.genderSwitch.on ? "m" : "f")
        self.headVC.switchActiveArray()
        self.bodyVC.switchActiveArray()
        self.legsVC.switchActiveArray()
    }
    
    func saveClicked() {
        var alertController = UIAlertController()
        var errors = false
        if(count(self.registerView.inputName.text) < 1) {
            alertController = UIAlertController(title: "Foutje", message:
                "Gelieve je naam in te vullen.", preferredStyle: UIAlertControllerStyle.Alert)
            errors = true
        } else if(count(self.registerView.inputEmail.text) < 1 || !isValidEmail(self.registerView.inputEmail.text)) {
            alertController = UIAlertController(title: "Foutje", message:
                "Gelieve je e-mailadres in te vullen.", preferredStyle: UIAlertControllerStyle.Alert)
            errors = true
        }
        
        if(errors) {
            alertController.addAction(UIAlertAction(title: "Oké mama", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            saveUser()
            self.navigationController?.setViewControllers([ChallengesViewController()], animated: true)
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    func saveUser() {
        let fileUploader = FileUploader()
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.bodyVC.characterPartView.imageView.frame.size.width, self.registerView.characterView.frame.size.height), false, 1)
        self.bodyVC.characterPartView.imageView.image?.drawInRect(CGRectMake(0, self.bodyVC.view.frame.origin.y, self.bodyVC.characterPartView.imageView.frame.width, self.bodyVC.characterPartView.imageView.frame.height))
        self.legsVC.characterPartView.imageView.image?.drawInRect(CGRectMake((self.bodyVC.characterPartView.imageView.frame.size.width - self.legsVC.characterPartView.imageView.frame.size.width) / 2, self.legsVC.view.frame.origin.y, self.legsVC.characterPartView.imageView.frame.width, self.legsVC.characterPartView.imageView.frame.height))
        self.headVC.characterPartView.imageView.image?.drawInRect(CGRectMake((self.bodyVC.characterPartView.imageView.frame.size.width - self.headVC.characterPartView.imageView.frame.size.width) / 2, self.headVC.view.frame.origin.y, self.headVC.characterPartView.imageView.frame.width, self.headVC.characterPartView.imageView.frame.height))
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        fileUploader.addFileData(UIImagePNGRepresentation(image), withName: "photo", withMimeType: "image/png")
        fileUploader.setValue(self.registerView.inputName.text, forParameter: "name")
        fileUploader.setValue(self.registerView.inputEmail.text, forParameter: "email")
        fileUploader.setValue(self.gender, forParameter: "gender")
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
