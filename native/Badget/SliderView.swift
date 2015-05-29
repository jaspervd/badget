//
//  SliderView.swift
//  Badget
//
//  Created by Jasper Van Damme on 29/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class SliderView: UIView {
    
    let scrollView:UIScrollView!
    let grouphuggerView:GrouphuggerView!
    let masterscoutView:MasterscoutView!
    let beerkingView:BeerkingView!
    
    override init(frame: CGRect) {
        self.scrollView = UIScrollView(frame: frame)
        self.grouphuggerView = GrouphuggerView(frame: frame)
        self.masterscoutView = MasterscoutView(frame: CGRect(x: frame.width, y: frame.origin.y, width: frame.width, height: frame.height))
        self.beerkingView = BeerkingView(frame: CGRect(x: frame.width * 2, y: frame.origin.y, width: frame.width, height: frame.height))
        
        super.init(frame: frame)
        
        self.addSubview(self.scrollView)
        createChallenges()
    }
    
    func createChallenges() {
        println("createChallenges()")
        self.scrollView.pagingEnabled = true
        self.scrollView.contentSize = CGSizeMake(frame.width * 3, 0)
        
        self.scrollView.addSubview(self.grouphuggerView)
        self.scrollView.addSubview(self.masterscoutView)
        self.scrollView.addSubview(self.beerkingView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
