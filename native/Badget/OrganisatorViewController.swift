//
//  OrganisatorViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import Alamofire

class OrganisatorViewController: UIViewController, ChallengeProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    var instructionView:InstructionView!
    var started:Bool = false
    var facesArray:Array<UIView> = []
    var smiles:Int = 0
    let imagePicker = UIImagePickerController()
    var image:UIImage!
    var scoreVC:ScoreViewController!
    var fileName:String {
        get {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            return documentsPath.stringByAppendingPathComponent("organisator.challenge")
        }
    }
    
    var organisatorView:OrganisatorView! {
        get {
            return self.view as! OrganisatorView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = OrganisatorView(frame: bounds)
        self.instructionView = InstructionView(frame: bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.instructionView)
        
        self.title = "Organisator"
        
        self.instructionView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
        self.organisatorView.btnRetake.addTarget(self, action: "retakeHandler", forControlEvents: UIControlEvents.TouchUpInside)
        self.organisatorView.btnContinue.addTarget(self, action: "didFinishChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didStartChallenge() {
        self.instructionView.removeFromSuperview()
        self.started = true
        
        self.organisatorView.scrollView.delegate = self
        
        var mediatypes = ["public.image"] as Array
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            self.imagePicker.sourceType = .Camera
        } else {
            self.imagePicker.sourceType = .PhotoLibrary
        }
        self.imagePicker.mediaTypes = mediatypes
        self.imagePicker.delegate = self
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func retakeHandler() {
        for fView in self.facesArray {
            fView.removeFromSuperview()
        }
        self.organisatorView.imageView.transform = CGAffineTransformMakeScale(1, 1)
        self.organisatorView.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
        self.smiles = 0
        self.facesArray = []
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        let image = CIImage(image: self.image)
        let features = detector.featuresInImage(image, options: [CIDetectorSmile:true])
        for feature in features {
            var featureBounds = feature.bounds
            featureBounds.origin.y = self.image.size.height - featureBounds.origin.y - featureBounds.size.height
            
            let fView = UIView(frame: featureBounds)
            fView.backgroundColor = UIColor(red: 73/255, green: 99/255, blue: 204/255, alpha: 0.6)
            
            self.facesArray.append(fView)
            self.organisatorView.imageView.addSubview(fView)
            if let smile = feature.hasSmile {
                if(smile) {
                    self.smiles++
                }
            }
        }
        
        let imageRect = CGRectMake(0, 0, self.image.size.width, self.image.size.height)
        self.organisatorView.imageView.frame = imageRect
        self.organisatorView.imageView.image = self.image
        self.organisatorView.scrollView.frame = self.view.frame
        
        let scaleX = self.organisatorView.bounds.size.width / self.image.size.width
        let scaleY = self.organisatorView.bounds.size.height / self.image.size.height
        let minZoomScale = max(scaleX, scaleY)
        self.organisatorView.scrollView.minimumZoomScale = minZoomScale
        self.organisatorView.scrollView.zoomScale = minZoomScale
        self.organisatorView.scrollView.maximumZoomScale = 4
        self.organisatorView.scrollView.setContentOffset(CGPointMake((self.image.size.width * minZoomScale - self.organisatorView.scrollView.frame.width) / 2, (self.image.size.height * minZoomScale - self.organisatorView.scrollView.frame.height) / 2), animated: false)
        
        self.organisatorView.scrollView.contentSize = CGSizeMake(self.image.size.width * minZoomScale, self.image.size.height * minZoomScale)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        self.organisatorView.scrollView.contentSize = CGSizeMake(self.image.size.width * scrollView.zoomScale, self.image.size.height * scrollView.zoomScale)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.organisatorView.imageView
    }
    
    func setScore(organisator: Organisator) {
        self.scoreVC = ScoreViewController(header: "Resultaat", feedback: "Je had \(organisator.friends) vrienden bij je!", badge: organisator.badge)
    }
    
    func didFinishChallenge() {
        self.started = false
        
        var friendsCount = self.facesArray.count
        var badge = Badge()
        if(friendsCount == 1) {
            badge = Badge(title: "Onafhankelijk", goal: "Trek een selfie!", image: UIImage(named: "av")!)
        } else if(friendsCount <= 5) {
            badge = Badge(title: "Moedig", goal: "Trek een foto met meer dan 1 persoon", image: UIImage(named: "av")!)
        } else if(friendsCount <= 10) {
            badge = Badge(title: "Sociaal", goal: "Trek een foto met meer dan 5 mensen", image: UIImage(named: "av")!)
        } else if(friendsCount <= 15) {
            badge = Badge(title: "Mensenkennis", goal: "Trek een foto met meer dan 10 mensen", image: UIImage(named: "av")!)
        } else if(friendsCount > 15) {
            badge = Badge(title: "Organisatietalent", goal: "Trek een foto met meer dan 15 mensen", image: UIImage(named: "av")!)
        }
        
        var organisator = Organisator(date: Settings.currentDate, friends: self.facesArray.count, badge: badge)
        if(NSKeyedArchiver.archiveRootObject(organisator, toFile: self.fileName)) {
            let parameters = [
                "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
                "day": Settings.currentDate,
                "friends": organisator.friends
            ]
            Alamofire.request(.POST, Settings.apiUrl + "/organisator", parameters: parameters)
            
            setScore(organisator)
            self.navigationController?.pushViewController(self.scoreVC, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
