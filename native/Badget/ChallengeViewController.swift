//
//  ChallengeViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 12/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController {
    
    weak var delegate:ChallengeDelegate?
    let viewController:UIViewController
    let navController:UINavigationController
    let header:String
    
    var challengeView:ChallengeView! {
        get {
            return self.view as! ChallengeView
        }
    }
    
    init(viewController: UIViewController, navController: UINavigationController, header: String) {
        self.viewController = viewController
        self.navController = navController
        self.header = header
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.challengeView.btnContinue.addTarget(self, action: "continueHandler", forControlEvents: UIControlEvents.TouchUpInside)
        self.challengeView.btnResult.addTarget(self, action: "resultHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func continueHandler() {
        self.navController.pushViewController(self.viewController, animated: true)
    }
    
    func resultHandler() {
        self.delegate?.willShowResult(self)
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = ChallengeView(frame: CGRectMake(self.navController.navigationBar.frame.height, 0, bounds.width, bounds.height - self.navController.navigationBar.frame.height), header: self.header)
    }
    
    func setDone() {
        self.challengeView.toggleResult()
        self.challengeView.imageView.image = UIImage(named: "manageruncolored") //\(self.header)
        self.challengeView.headerView.image = UIImage(named: "\(self.header)functietitleuncolored")
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
