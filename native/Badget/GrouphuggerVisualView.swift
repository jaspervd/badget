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
    let btnRetake:UIButton!
    let btnContinue:UIButton!

    override init(frame: CGRect) {
        self.scrollView = UIScrollView(frame: frame)
        self.imageView = UIImageView(frame: frame)
        self.btnRetake = UIButton.buttonWithType(.System) as! UIButton
        self.btnContinue = UIButton.buttonWithType(.System) as! UIButton
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.btnRetake.frame = CGRectMake(0, frame.height - 88, frame.width, 44)
        self.btnRetake.setTitle("Nog een keer", forState: .Normal)
        
        self.btnContinue.frame = CGRectMake(0, frame.height - 44, frame.width, 44)
        self.btnContinue.setTitle("Oké, dit is 'em!", forState: .Normal)
        
        self.scrollView.bounces = false
        self.scrollView.addSubview(self.imageView)
        self.addSubview(self.scrollView)
        self.addSubview(self.btnRetake)
        self.addSubview(self.btnContinue)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
