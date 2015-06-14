//
//  InfoViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 10/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UIScrollViewDelegate {
    
    var pageControl:UIPageControl!
    
    var scrollView:UIScrollView! {
        get {
            return self.view as! UIScrollView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        
        self.title = "Info"
        
        createPages()
        self.pageControl = UIPageControl(frame: CGRectMake(0, self.view.frame.height - 30, self.view.frame.width, 20))
        self.pageControl.numberOfPages = Int(self.scrollView.contentSize.width / self.scrollView.frame.width)
        self.pageControl.addTarget(self, action: "changePage", forControlEvents: UIControlEvents.ValueChanged)
        self.scrollView.addSubview(self.pageControl)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeHandler")
        swipeDown.direction = .Down
        
        self.view.addGestureRecognizer(swipeDown)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIScrollView(frame: bounds);
    }
    
    func createPages() {
        var xPos:CGFloat = 0
        for index in 1...3 {
            let view = UIView(frame: CGRectMake(xPos, 0, self.view.frame.width, self.view.frame.height))
            self.view.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(view)
            xPos += self.view.frame.width
        }
        self.scrollView.contentSize = CGSizeMake(xPos, 0)
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
    }
    
    func changePage() {
        let xPos = CGFloat(self.pageControl.currentPage * Int(self.scrollView.frame.size.width))
        self.scrollView.setContentOffset(CGPointMake(xPos, 0), animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.pageControl.frame.origin.x = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipeHandler() {
        self.navigationController?.popViewControllerAnimated(true)
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
