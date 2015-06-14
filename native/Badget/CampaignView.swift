//
//  CampaignView.swift
//  Badget
//
//  Created by Jasper Van Damme on 14/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CampaignView: UIView {

    let campaignText:UITextView
    let btnContinue:UIButton
    
    override init(frame: CGRect) {
        self.campaignText = UITextView(frame: CGRectMake(10, 50, 300, 400))
        self.campaignText.text = "Intro campagne"
        self.campaignText.editable = false
        
        self.btnContinue = UIButton(frame: CGRectMake(10, self.campaignText.frame.origin.y + self.campaignText.frame.height + 10, 300, 40))
        self.btnContinue.setTitle("Ga verder", forState: UIControlState.Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(self.campaignText)
        self.addSubview(self.btnContinue)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
