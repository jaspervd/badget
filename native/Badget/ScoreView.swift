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
    let blurEffectView:UIVisualEffectView
    let badgesView:UIView
    let badgeSize = CGSizeMake(50, 50)
    
    init(frame: CGRect, header: String, feedback: String, badges: Array<Badge>) {
        self.btnClose = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        self.blurEffectView.frame = frame
        self.badgesView = UIView()
        
        super.init(frame: frame)
        
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.addSubview(self.blurEffectView)
        } else {
            self.backgroundColor = UIColor(white: 0, alpha: 0.3)
        }
        
        let scoreHolder = UIView(frame: CGRectMake(30, 40, frame.width - 60, 300))
        scoreHolder.backgroundColor = UIColor.whiteColor()
        
        let headerText = UILabel(frame: CGRectMake(10, 20, scoreHolder.frame.width - 20, 44))
        headerText.text = header
        headerText.textAlignment = .Center
        
        let feedbackText = UITextView(frame: CGRectMake(10, headerText.frame.origin.y + headerText.frame.size.height + 20, scoreHolder.frame.width - 20, 44))
        feedbackText.text = feedback
        feedbackText.backgroundColor = nil
        feedbackText.editable = false
        
        let rows = round(CGFloat(badges.count) / 4)
        self.badgesView.frame = CGRectMake(10, feedbackText.frame.origin.y + feedbackText.frame.size.height + 20, scoreHolder.frame.width - 20, self.badgeSize.height * rows)
        
        self.btnClose.frame = CGRectMake(10, badgesView.frame.origin.y + badgesView.frame.height + 10, scoreHolder.frame.width - 20, 44)
        self.btnClose.setTitle("Done!", forState: UIControlState.Normal)
        
        scoreHolder.frame.size.height = 40 + headerText.frame.size.height + 20 + feedbackText.frame.size.height + 10 + self.badgesView.frame.size.height + self.btnClose.frame.size.height
        scoreHolder.center = CGPointMake(frame.width / 2, frame.height / 2)
        
        scoreHolder.addSubview(headerText)
        scoreHolder.addSubview(feedbackText)
        scoreHolder.addSubview(badgesView)
        scoreHolder.addSubview(self.btnClose)
        
        self.addSubview(scoreHolder)
    }
    
    func createBadges(badges:Array<BadgeView>) {
        var xPos:CGFloat = 0
        var yPos:CGFloat = 0
        for (index, badgeView) in enumerate(badges) {
            self.badgesView.addSubview(badgeView)
            badgeView.frame = CGRectMake(xPos, yPos, self.badgeSize.width, self.badgeSize.height)
            xPos += self.badgeSize.width + 7.5
            if((index + 1) % 4 == 0) {
                yPos += 7.5 + self.badgeSize.height
                xPos = 0
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
