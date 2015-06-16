//
//  ScoreView.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ScoreView: UIView {

    let btnOk:UIButton!
    let badgesView:UIView
    let badgeSize = CGSizeMake(77, 87)
    
    init(frame: CGRect, feedback: String) {
        let scoreHolder = UIImageView(image: UIImage(named: "resultaatbg"))
        scoreHolder.center = CGPointMake(frame.width / 2, frame.height / 2 + 40)
        scoreHolder.userInteractionEnabled = true
        
        let headerView = UIImageView(image: UIImage(named: "resultaattitle"))
        headerView.frame = CGRectMake((scoreHolder.frame.width - headerView.frame.width) / 2, 45, headerView.frame.width, headerView.frame.height)
        
        let feedbackText = UILabel(frame: CGRectMake(0, 0, scoreHolder.frame.width - 30, 44))
        feedbackText.text = feedback
        feedbackText.font = UIFont(name: "Dosis-Bold", size: 16)
        feedbackText.textColor = Settings.blueColor
        feedbackText.numberOfLines = 0
        feedbackText.textAlignment = .Center
        feedbackText.sizeToFit()
        feedbackText.frame.origin = CGPointMake((scoreHolder.frame.width - feedbackText.frame.width) / 2, headerView.frame.origin.y + headerView.frame.size.height + 15)
        
        self.badgesView = UIView(frame: CGRectMake((scoreHolder.frame.width - self.badgeSize.width) / 2, feedbackText.frame.origin.y + feedbackText.frame.size.height + 20, self.badgeSize.width, self.badgeSize.height))
        
        let okImage = UIImage(named: "okbtn")!
        self.btnOk = UIButton(frame: CGRectMake((scoreHolder.frame.width - okImage.size.width) / 2, scoreHolder.frame.height - okImage.size.height - 50, okImage.size.width, okImage.size.height))
        self.btnOk.setBackgroundImage(okImage, forState: .Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor

        scoreHolder.addSubview(headerView)
        scoreHolder.addSubview(feedbackText)
        scoreHolder.addSubview(self.badgesView)
        scoreHolder.addSubview(self.btnOk)
        
        self.addSubview(scoreHolder)
    }
    
    func showBadge(badgeView:BadgeView) {
        self.badgesView.addSubview(badgeView)
        badgeView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        badgeView.alpha = 0
        UIView.animateWithDuration(1, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            badgeView.transform = CGAffineTransformMakeScale(1, 1)
            badgeView.alpha = 1
        }, completion: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
