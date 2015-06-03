//
//  StartViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var startView:StartView! {
        get {
            return self.view as! StartView
        }
    }
    
    let challengesVC = ChallengesViewController()
    var image:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startView.btnContinue.addTarget(self, action: "continueClicked", forControlEvents: UIControlEvents.TouchUpInside)
            self.startView.btnPhoto.addTarget(self, action: "photoClicked", forControlEvents: UIControlEvents.TouchUpInside)
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
    }
    
    func continueClicked() {
        self.startView.showCredentials()
    }
    
    func saveClicked() {
        // upload data to api (if online) / otherwise store offline
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
        } else if(self.image == nil) {
            alertController = UIAlertController(title: "Foutje", message:
                "Gelieve een foto up te loaden.", preferredStyle: UIAlertControllerStyle.Alert)
            errors = true
        }
        
        if(errors) {
            alertController.addAction(UIAlertAction(title: "Oké mama", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.presentViewController(self.challengesVC, animated: true, completion: nil)
        }
    }
    
    func photoClicked() {
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            var mediatypes = ["public.image"] as Array
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = mediatypes
            imagePicker.delegate = self
            self.presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            println("Geen camera beschikbaar")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.startView.btnPhoto.setBackgroundImage(self.image, forState: UIControlState.Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
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
