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

    let circularScrollView:CircularScrollView
    let leftBtn:UIButton
    let rightBtn:UIButton
    
    override init(frame: CGRect) {
        self.circularScrollView = CircularScrollView(frame: frame)
        self.leftBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.rightBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.circularScrollView.backgroundColor = nil
        
        let infoText = UITextView(frame: CGRectMake(20, frame.height - 80, frame.width - 40, 80))
        infoText.backgroundColor = nil
        infoText.editable = false
        infoText.textColor = UIColor.whiteColor()
        infoText.text = "Ga naar de Randstad stand om de uitdaging aan te gaan."
        
        self.leftBtn.frame = CGRectMake(0, frame.height / 2 - 22, 30, 44)
        self.leftBtn.setTitle("<", forState: UIControlState.Normal)
        self.leftBtn.backgroundColor = UIColor.whiteColor()
        
        self.rightBtn.frame = CGRectMake(frame.width - 30, frame.height / 2 - 22, 30, 44)
        self.rightBtn.setTitle(">", forState: UIControlState.Normal)
        self.rightBtn.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(self.circularScrollView)
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(infoText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
