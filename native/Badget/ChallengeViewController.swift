//
//  ChallengeViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 12/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {
    
    let viewController:UIViewController
    let navController:UINavigationController
    let image:UIImage
    let header:String
    
    var challengeView:ChallengeView! {
        get {
            return self.view as! ChallengeView
        }
    }
    
    init(viewController: UIViewController, navController: UINavigationController, image: UIImage, header: String) {
        self.viewController = viewController
        self.navController = navController
        self.image = image
        self.header = header
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.challengeView.btnContinue.addTarget(self, action: "continueHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func continueHandler() {
        self.navController.pushViewController(self.viewController, animated: true)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = ChallengeView(frame: bounds, photo: self.image, header: self.header)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
