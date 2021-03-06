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
    let instructionText:UILabel
    let photoHolder:UIImageView
    let scrollView:UIScrollView
    let imageView:UIImageView
    let btnCamera:UIButton
    let friendsImage:UIImageView
    let friendsText:UILabel
    let btnRetake:UIButton
    let btnContinue:UIButton

    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "organisatortitle")!)
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.instructionText = UILabel(frame: CGRectMake(0, 0, frame.width - 40, 75))
        self.instructionText.text = "Probeer zo veel mogelijk vrienden en/of omstaanders mee op de foto te krijgen. Hoe meer mensen, hoe beter!"
        self.instructionText.font = UIFont(name: "Dosis-Bold", size: 16)
        self.instructionText.textColor = Settings.blueColor
        self.instructionText.numberOfLines = 0
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        self.photoHolder = UIImageView(image: UIImage(named: "photoborder")!)
        self.photoHolder.frame = CGRectMake(0, self.instructionText.frame.size.height + 150, self.photoHolder.frame.size.width, self.photoHolder.frame.size.height)
        self.photoHolder.userInteractionEnabled = true
        
        self.scrollView = UIScrollView(frame: self.photoHolder.frame)
        self.imageView = UIImageView(frame: frame)

        let cameraImage = UIImage(named: "fotobtn")!
        self.btnCamera = UIButton(frame: CGRectMake((self.photoHolder.frame.size.width - cameraImage.size.width) / 2, (self.photoHolder.frame.size.height - cameraImage.size.height) / 2, cameraImage.size.width, cameraImage.size.height))
        self.btnCamera.setBackgroundImage(cameraImage, forState: .Normal)
        
        self.friendsImage = UIImageView(image: UIImage(named: "friendsicon"))
        self.friendsImage.frame.origin = CGPointMake(50, self.photoHolder.frame.origin.y + self.photoHolder.frame.height + 15)
        
        self.friendsText = UILabel(frame: CGRectMake(self.friendsImage.frame.size.width + self.friendsImage.frame.origin.x + 15, self.friendsImage.frame.origin.y, 100, self.friendsImage.frame.height))
        self.friendsText.text = "0 VRIENDEN"
        self.friendsText.font = UIFont(name: "Dosis-Bold", size: 30)
        self.friendsText.textColor = Settings.grayColor
        self.friendsText.sizeToFit()
        
        let retakeImage = UIImage(named: "opnieuwbtn")!
        self.btnRetake = UIButton(frame: CGRectMake(35, self.photoHolder.frame.origin.y + self.photoHolder.frame.size.height + 65, retakeImage.size.width, retakeImage.size.height))
        self.btnRetake.setBackgroundImage(retakeImage, forState: .Normal)
        
        let continueImage = UIImage(named: "okbtn")!
        self.btnContinue = UIButton(frame: CGRectMake(frame.width - continueImage.size.width - 35, self.photoHolder.frame.origin.y + self.photoHolder.frame.size.height + 65, continueImage.size.width, continueImage.size.height))
        self.btnContinue.setBackgroundImage(continueImage, forState: .Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.scrollView.backgroundColor = Settings.blueColor
        self.scrollView.bounces = false
        self.scrollView.addSubview(self.imageView)
        
        self.addSubview(self.titleView)
        self.addSubview(self.instructionText)
        self.addSubview(self.scrollView)
        self.addSubview(self.photoHolder)
        self.addSubview(self.friendsImage)
        self.addSubview(self.friendsText)
        self.photoHolder.addSubview(self.btnCamera)
    }
    
    func showButtons() {
        self.addSubview(self.btnRetake)
        self.addSubview(self.btnContinue)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
