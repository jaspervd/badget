//
//  ChallengesView.swift
//  Badget
//
//  Created by Jasper Van Damme on 12/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CircularScrollView

class ChallengesView: UIView {
    
    let titleView:UIImageView
    let circularScrollView:CircularScrollView
    let leftBtn:ArrowButton
    let rightBtn:ArrowButton
    
    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "uitdagingentitle"))
        self.circularScrollView = CircularScrollView(frame: frame)
        self.leftBtn = ArrowButton()
        self.rightBtn = ArrowButton()
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.circularScrollView.backgroundColor = UIColor.clearColor()
        
        let infoText = UITextView(frame: CGRectMake(50, frame.height - 80, frame.width - 100, 80))
        infoText.backgroundColor = nil
        infoText.editable = false
        infoText.textColor = UIColor(red: 117/255, green: 192/255, blue: 204/255, alpha: 1)
        infoText.font = UIFont.systemFontOfSize(14, weight: 700)
        infoText.text = "Ga naar de Randstad stand om de uitdaging aan te gaan."
        infoText.textAlignment = .Center
        
        self.leftBtn.frame = CGRectMake(10, frame.height / 2 - 22, 30, 44)
        self.leftBtn.setDirection(.Left)
        
        self.rightBtn.frame = CGRectMake(frame.width - 40, frame.height / 2 - 22, 30, 44)
        self.rightBtn.setDirection(.Right)
    
        let overviewBar = UIImageView(image: UIImage(named: "overviewbar"))
        overviewBar.frame = CGRectMake((frame.width - overviewBar.frame.width) / 2, 110, overviewBar.frame.width, overviewBar.frame.height)
        
        self.addSubview(self.titleView)
        self.addSubview(overviewBar)
        self.addSubview(self.circularScrollView)
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(infoText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
