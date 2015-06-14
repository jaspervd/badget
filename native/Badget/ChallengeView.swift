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
    
    init(frame: CGRect, photo: UIImage, header: String) {
        self.btnContinue = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        let passHolder = UIView(frame: CGRectMake(0, 0, frame.size.width - 60, 350))
        passHolder.center = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        passHolder.backgroundColor = UIColor.whiteColor()
        
        let imageView = UIImageView(image: photo)
        imageView.frame = CGRectMake((passHolder.frame.size.width - photo.size.width) / 2, 40, photo.size.width, photo.size.height)
        
        let titleText = UILabel(frame: CGRectMake(10, imageView.frame.origin.y + imageView.frame.height + 10, passHolder.frame.size.width - 20, 44))
        titleText.text = header
        titleText.textAlignment = .Center
        
        btnContinue.frame = CGRectMake(10, titleText.frame.origin.y + titleText.frame.height + 10, passHolder.frame.size.width - 20, 44)
        btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        
        passHolder.addSubview(imageView)
        passHolder.addSubview(titleText)
        passHolder.addSubview(self.btnContinue)
        self.addSubview(passHolder)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
