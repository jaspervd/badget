//
//  ChallengeView.swift
//  Badget
//
//  Created by Jasper Van Damme on 10/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ChallengeView: UIView {
    let btnContinue:UIButton!
    
    init(frame: CGRect, photo: UIImage, title: String, intro: String) {
        self.btnContinue = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        super.init(frame: frame)
        
        let passView = UIView(frame: CGRectMake(30, 40, frame.width - 60, 300))
        passView.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: photo)
        imageView.frame = CGRectMake(passView.frame.width / 2 - 50, 40, 100, 100)
        
        let titleText = UILabel(frame: CGRectMake(10, imageView.frame.origin.y + imageView.frame.height + 20, passView.frame.width - 20, 44))
        titleText.text = title
        titleText.textAlignment = .Center
        
        btnContinue.frame = CGRectMake(10, titleText.frame.origin.y + titleText.frame.height + 20, passView.frame.width - 20, 44)
        btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        
        let introText = UITextView(frame: CGRectMake(passView.frame.origin.x, passView.frame.origin.y + passView.frame.height + 40, frame.width - 40, 100))
        introText.text = intro
        introText.textColor = UIColor.whiteColor()
        introText.backgroundColor = nil
        
        passView.addSubview(imageView)
        passView.addSubview(titleText)
        passView.addSubview(self.btnContinue)
        
        self.addSubview(passView)
        self.addSubview(introText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
