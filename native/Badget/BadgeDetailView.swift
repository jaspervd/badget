//
//  BadgeDetailView.swift
//  Badget
//
//  Created by Jasper Van Damme on 16/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BadgeDetailView: UIView {
    
    let btnClose:UIButton

    init(frame: CGRect, badge: Badge) {
        let detailBg = UIImageView(image: UIImage(named: "badgedetailbg"))
        detailBg.center = CGPointMake(frame.width / 2, frame.height / 2)
        detailBg.userInteractionEnabled = true
        
        let titleView = UILabel(frame: CGRectMake(0, 40, detailBg.frame.width, 40))
        titleView.text = badge.title.uppercaseString
        titleView.font = UIFont(name: "Dosis-Bold", size: 24)
        titleView.textColor = Settings.grayColor
        titleView.textAlignment = .Center
        
        let detailView = UILabel(frame: CGRectMake(30, 100, detailBg.frame.width - 60, 200))
        detailView.text = badge.goal
        detailView.font = UIFont(name: "Dosis-Bold", size: 16)
        detailView.textColor = Settings.blueColor
        detailView.textAlignment = .Center
        detailView.numberOfLines = 0
        detailView.sizeToFit()
        
        let closeImage = UIImage(named: "closebtn")!
        self.btnClose = UIButton(frame: CGRectMake(detailBg.frame.width - closeImage.size.width - 14, 30, closeImage.size.width, closeImage.size.height))
        self.btnClose.setBackgroundImage(closeImage, forState: .Normal)
        
        super.init(frame: frame)
        
        self.addSubview(detailBg)
        detailBg.addSubview(titleView)
        detailBg.addSubview(detailView)
        detailBg.addSubview(self.btnClose)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
