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
        // TODO: check input
        // upload data to api (if online) / otherwise store offline
        self.presentViewController(self.challengesVC, animated: true, completion: nil)
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
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.startView.btnPhoto.setBackgroundImage(image, forState: UIControlState.Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
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
