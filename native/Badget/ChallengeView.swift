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
    
    init(frame: CGRect, header: String) {
        self.btnContinue = UIButton()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let passHolder = UIImageView(image: UIImage(named: "uitdagingbg"))
        passHolder.center = CGPointMake(frame.width / 2, frame.height / 2 + 18)
        passHolder.userInteractionEnabled = true
        
        let photo = UIImage(named: "managercolored")! // \(header)
        let imageView = UIImageView(image: photo)
        imageView.frame = CGRectMake((passHolder.frame.size.width - photo.size.width) / 2, 50, photo.size.width, photo.size.height)
        
        let headerImage = UIImage(named: "\(header)functietitlecolored")!
        let headerView = UIImageView(image: headerImage)
        headerView.frame = CGRectMake((passHolder.frame.width - headerImage.size.width) / 2, imageView.frame.origin.y + imageView.frame.height + 12, headerImage.size.width, headerImage.size.height)
        
        let activeImage = UIImage(named: "beginbtnactive")!
        self.btnContinue.frame = CGRectMake((passHolder.frame.width - activeImage.size.width) / 2, headerView.frame.origin.y + headerView.frame.height + 20, activeImage.size.width, activeImage.size.height)
        self.btnContinue.setBackgroundImage(activeImage, forState: .Normal)
        self.btnContinue.setBackgroundImage(UIImage(named: "beginbtninactive"), forState: .Disabled)
        self.btnContinue.enabled = false
        
        passHolder.addSubview(imageView)
        passHolder.addSubview(headerView)
        passHolder.addSubview(self.btnContinue)
        self.addSubview(passHolder)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
