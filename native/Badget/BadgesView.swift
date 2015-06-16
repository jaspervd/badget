//
//  BadgesView.swift
//  Badget
//
//  Created by Jasper Van Damme on 16/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgesView: UIView {
    
    let titleView:UIImageView
    let badges:UIView

    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "badgestitle")!)
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.badges = UIView(frame: CGRectMake((frame.width - 250) / 2, 150, 250, frame.height))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.addSubview(self.titleView)
        self.addSubview(self.badges)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
