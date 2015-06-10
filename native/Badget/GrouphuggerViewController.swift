//
//  TableViewController.swift
//  BluetoothTest
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import Alamofire

class GrouphuggerViewController: UIViewController, ChallengeProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    var detailView:GrouphuggerDetailView!
    var visualView:GrouphuggerVisualView!
    var started:Bool = false
    var facesArray:Array<UIView> = []
    var smiles:Int = 0
    let imagePicker = UIImagePickerController()
    var image:UIImage!
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
        self.detailView = GrouphuggerDetailView(frame: bounds)
        self.visualView = GrouphuggerVisualView(frame: bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        
        self.title = "Grouphugger"
        
        self.detailView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
        self.visualView.btnRetake.addTarget(self, action: "retakeHandler", forControlEvents: UIControlEvents.TouchUpInside)
        self.visualView.btnContinue.addTarget(self, action: "didFinishChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didStartChallenge() {
        UIView.transitionFromView(self.detailView, toView: self.visualView, duration: 1, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.started = true
        
        self.visualView.scrollView.delegate = self
        
        var mediatypes = ["public.image"] as Array
        if(UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            self.imagePicker.sourceType = .Camera
        } else {
            self.imagePicker.sourceType = .PhotoLibrary
        }
        self.imagePicker.mediaTypes = mediatypes
        self.imagePicker.delegate = self
        self.imagePicker.modalTransitionStyle = .CrossDissolve
        self.imagePicker.modalPresentationStyle = .CurrentContext
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    func retakeHandler() {
        for fView in self.facesArray {
            fView.removeFromSuperview()
        }
        self.visualView.imageView.transform = CGAffineTransformMakeScale(1, 1)
        self.visualView.scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
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
            self.visualView.imageView.addSubview(fView)
            if let smile = feature.hasSmile {
                if(smile) {
                    self.smiles++
                }
            }
        }
        
        let imageRect = CGRectMake(0, 0, self.image.size.width, self.image.size.height)
        self.visualView.imageView.frame = imageRect
        self.visualView.imageView.image = self.image
        self.visualView.scrollView.frame = self.view.frame
        self.visualView.scrollView.contentSize = self.image.size
        
        let scaleX = self.visualView.bounds.size.width / self.visualView.scrollView.contentSize.width
        let scaleY = self.visualView.bounds.size.height / self.visualView.scrollView.contentSize.height
        let minZoomScale = max(scaleX, scaleY)
        self.visualView.scrollView.minimumZoomScale = minZoomScale
        self.visualView.scrollView.zoomScale = minZoomScale
        self.visualView.scrollView.maximumZoomScale = 4
        self.visualView.scrollView.setContentOffset(CGPointMake(self.image.size.width / 2 * minZoomScale, 0), animated: false)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.visualView.imageView
    }
    
    func didFinishChallenge() {
        self.started = false
        var grouphugger = Grouphugger(friends: self.facesArray.count)
        NSUserDefaults.standardUserDefaults().setObject(Settings.currentDate, forKey: "grouphuggerDate")
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(grouphugger), forKey: "grouphuggerLastScore")
        let parameters = [
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
            "day": Settings.currentDate,
            "friends": grouphugger.friends
        ]
        Alamofire.request(.POST, Settings.apiUrl + "/grouphugger", parameters: parameters)
        
        let scoreVC = ScoreViewController(header: "Resultaat", feedback: "Je had \(grouphugger.friends) vrienden bij je!", badges: [])
        scoreVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(scoreVC, animated: true, completion: nil)
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
