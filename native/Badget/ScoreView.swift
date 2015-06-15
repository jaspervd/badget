//
//  ScoreView.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    let btnClose:UIButton!
    let badgesView:UIView
    let badgeSize = CGSizeMake(50, 50)
    
    init(frame: CGRect, header: String, feedback: String, badge: Badge?) {
        self.btnClose = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.badgesView = UIView()
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        let scoreHolder = UIView(frame: CGRectMake(30, 40, frame.width - 60, 300))
        scoreHolder.backgroundColor = UIColor.whiteColor()
        
        let headerText = UILabel(frame: CGRectMake(10, 20, scoreHolder.frame.width - 20, 44))
        headerText.text = header
        headerText.textAlignment = .Center
        
        let feedbackText = UITextView(frame: CGRectMake(10, headerText.frame.origin.y + headerText.frame.size.height + 20, scoreHolder.frame.width - 20, 44))
        feedbackText.text = feedback
        feedbackText.backgroundColor = nil
        feedbackText.editable = false
        
        self.badgesView.frame = CGRectMake(10, feedbackText.frame.origin.y + feedbackText.frame.size.height + 20, scoreHolder.frame.width - 20, self.badgeSize.height)
        
        self.btnClose.frame = CGRectMake(10, badgesView.frame.origin.y + badgesView.frame.height + 10, scoreHolder.frame.width - 20, 44)
        self.btnClose.setTitle("Done!", forState: UIControlState.Normal)
        
        scoreHolder.frame.size.height = 40 + headerText.frame.size.height + 20 + feedbackText.frame.size.height + 10 + self.badgesView.frame.size.height + self.btnClose.frame.size.height
        scoreHolder.center = CGPointMake(frame.width / 2, frame.height / 2)
        
        scoreHolder.addSubview(headerText)
        scoreHolder.addSubview(feedbackText)
        scoreHolder.addSubview(self.badgesView)
        scoreHolder.addSubview(self.btnClose)
        
        self.addSubview(scoreHolder)
    }
    
    func showBadge(badgeView:BadgeView) {
        self.badgesView.addSubview(badgeView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
