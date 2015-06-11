//
//  BadgeView.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgeView: UIView {
    let badge:Badge
    let imageBtn:UIButton

    init(frame: CGRect, badge: Badge) {
        self.badge = badge
        self.imageBtn = UIButton(frame: CGRectMake(0, 0, 50, 50))
        super.init(frame: frame)
        
        self.imageBtn.setBackgroundImage(badge.image, forState: UIControlState.Normal)
        self.addSubview(self.imageBtn)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
