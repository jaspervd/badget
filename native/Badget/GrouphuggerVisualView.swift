//
//  GrouphuggerVisualView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class GrouphuggerVisualView: UIView {
    
    let scrollView:UIScrollView!
    let imageView:UIImageView!
    let retakeBtn:UIButton!

    override init(frame: CGRect) {
        self.scrollView = UIScrollView(frame: frame)
        self.imageView = UIImageView(frame: frame)
        self.retakeBtn = UIButton.buttonWithType(.System) as! UIButton
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.retakeBtn.frame = CGRectMake(0, frame.height - 50, frame.width, 44)
        self.retakeBtn.setTitle("Nog een keer", forState: .Normal)
        
        self.scrollView.bounces = false
        self.scrollView.addSubview(self.imageView)
        self.addSubview(self.scrollView)
        self.addSubview(self.retakeBtn)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
