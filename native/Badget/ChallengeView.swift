//
//  ChallengeView.swift
//  Badget
//
//  Created by Jasper Van Damme on 10/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ChallengeView: UIView {
    let btnContinue:UIButton
    let passHolder:UIImageView
    let imageView:UIImageView
    let headerView:UIImageView
    let completedView:UIImageView
    let btnResult:UIButton
    
    init(frame: CGRect, header: String) {
        self.btnContinue = UIButton()
        self.passHolder = UIImageView(image: UIImage(named: "uitdagingbg"))
        
        let photo = UIImage(named: "managercolored")! // \(header)
        self.imageView = UIImageView(image: photo)
        
        let headerImage = UIImage(named: "\(header)functietitlecolored")!
        self.headerView = UIImageView(image: headerImage)
    
        let completedImage = UIImage(named: "voltooid")!
        self.completedView = UIImageView(image: completedImage)
        self.btnResult = UIButton()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.passHolder.center = CGPointMake(frame.width / 2, frame.height / 2 + 18)
        self.passHolder.userInteractionEnabled = true
        
        self.imageView.frame = CGRectMake((self.passHolder.frame.size.width - photo.size.width) / 2, 50, photo.size.width, photo.size.height)
        
        self.headerView.frame = CGRectMake((self.passHolder.frame.width - headerImage.size.width) / 2, self.imageView.frame.origin.y + self.imageView.frame.height + 12, headerImage.size.width, headerImage.size.height)
        
        let activeImage = UIImage(named: "beginbtnactive")!
        self.btnContinue.frame = CGRectMake((self.passHolder.frame.width - activeImage.size.width) / 2, self.headerView.frame.origin.y + self.headerView.frame.height + 20, activeImage.size.width, activeImage.size.height)
        self.btnContinue.setBackgroundImage(activeImage, forState: .Normal)
        self.btnContinue.setBackgroundImage(UIImage(named: "beginbtninactive"), forState: .Disabled)
        self.btnContinue.enabled = false
        
        self.completedView.frame = CGRectMake((self.passHolder.frame.size.width - completedImage.size.width) / 2, (self.imageView.frame.size.height - completedImage.size.height) / 2 + self.imageView.frame.origin.x + 20, completedImage.size.width, completedImage.size.height)
        self.completedView.hidden = true
        
        let resultImage = UIImage(named: "resultaatbtn")!
        self.btnResult.frame = CGRectMake((self.passHolder.frame.width - resultImage.size.width) / 2, self.headerView.frame.origin.y + self.headerView.frame.height + 20, resultImage.size.width, resultImage.size.height)
        self.btnResult.setBackgroundImage(resultImage, forState: .Normal)
        self.btnResult.hidden = true
        
        self.passHolder.addSubview(self.imageView)
        self.passHolder.addSubview(self.headerView)
        self.passHolder.addSubview(self.btnContinue)
        self.passHolder.addSubview(self.completedView)
        self.passHolder.addSubview(self.btnResult)
        self.addSubview(self.passHolder)
    }
    
    func toggleResult() {
        self.completedView.hidden = false
        self.btnResult.hidden = false
        self.btnResult.hidden = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
