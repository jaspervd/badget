//
//  OrganisatorView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class OrganisatorView: UIView {
    
    let titleView:UIImageView
    let instructionText:UITextView
    let photoHolder:UIImageView
    let scrollView:UIScrollView
    let imageView:UIImageView
    let btnCamera:UIButton
    let btnRetake:UIButton
    let btnContinue:UIButton

    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "organisatortitle")!)
        self.instructionText = UITextView(frame: CGRectMake(0, 0, frame.width - 40, 75))
        
        self.photoHolder = UIImageView(image: UIImage(named: "photoborder")!)
        self.photoHolder.frame = CGRectMake(0, self.instructionText.frame.size.height + 140, self.photoHolder.frame.size.width, self.photoHolder.frame.size.height)
        self.photoHolder.userInteractionEnabled = true
        
        self.scrollView = UIScrollView(frame: self.photoHolder.frame)
        self.imageView = UIImageView(frame: frame)
        self.btnCamera = UIButton()
        self.btnRetake = UIButton()
        self.btnContinue = UIButton()
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.instructionText.text = "Probeer zo veel mogelijk vrienden en/of omstaanders mee op de foto te staan. Hoe meer mensen, hoe beter!"
        self.instructionText.font = UIFont.systemFontOfSize(14)
        self.instructionText.backgroundColor = UIColor.clearColor()
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        let cameraImage = UIImage(named: "fotobtn")!
        self.btnCamera.frame = CGRectMake((self.photoHolder.frame.size.width - cameraImage.size.width) / 2, (self.photoHolder.frame.size.height - cameraImage.size.height) / 2, cameraImage.size.width, cameraImage.size.height)
        self.btnCamera.setBackgroundImage(cameraImage, forState: .Normal)
        
        let retakeImage = UIImage(named: "okbtn")!
        self.btnRetake.frame = CGRectMake(35, self.photoHolder.frame.origin.y + self.photoHolder.frame.size.height + 75, retakeImage.size.width, retakeImage.size.height)
        self.btnRetake.setBackgroundImage(retakeImage, forState: .Normal)
        
        let continueImage = UIImage(named: "okbtn")!
        self.btnContinue.frame = CGRectMake(frame.width - continueImage.size.width - 35, self.photoHolder.frame.origin.y + self.photoHolder.frame.size.height + 75, continueImage.size.width, continueImage.size.height)
        self.btnContinue.setBackgroundImage(continueImage, forState: .Normal)
        
        self.scrollView.backgroundColor = Settings.blueColor
        self.scrollView.bounces = false
        self.scrollView.addSubview(self.imageView)
        self.addSubview(self.titleView)
        self.addSubview(self.instructionText)
        self.addSubview(self.scrollView)
        self.addSubview(self.photoHolder)
        self.photoHolder.addSubview(self.btnCamera)
        self.addSubview(self.btnRetake)
        self.addSubview(self.btnContinue)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
