//
//  StartView.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CircularScrollView

class StartView: UIView {
    
    let campaignText:UITextView
    let btnContinue:UIButton
    let inputName:UITextField
    let inputEmail:UITextField
    let btnSave:UIButton
    let genderSwitch:UISwitch
    
    override init(frame: CGRect) {
        self.campaignText = UITextView(frame: CGRectMake(10, 50, 300, 400))
        self.campaignText.text = "Intro campagne"
        self.campaignText.editable = false
        
        self.btnContinue = UIButton(frame: CGRectMake(10, self.campaignText.frame.origin.y + self.campaignText.frame.height + 10, 300, 40))
        self.btnContinue.setTitle("Ga verder", forState: UIControlState.Normal)
        
        self.genderSwitch = UISwitch(frame: CGRectMake(10, 400, 44, 100))
        self.genderSwitch.center = CGPointMake(frame.width / 2, self.genderSwitch.frame.origin.y)
        self.genderSwitch.hidden = true
        
        self.inputName = UITextField(frame: CGRectMake(10, self.genderSwitch.frame.origin.y + self.genderSwitch.frame.height + 10, 300, 40))
        self.inputName.hidden = true
        self.inputName.placeholder = "Chokri Mahassine"
        self.inputName.autocapitalizationType = .Words
        
        self.inputEmail = UITextField(frame: CGRectMake(10, self.inputName.frame.origin.y + self.inputName.frame.height + 10, 300, 40))
        self.inputEmail.hidden = true
        self.inputEmail.placeholder = "chokri.mahassine@pukkelpop.be"
        self.inputEmail.autocapitalizationType = .None
        self.inputEmail.keyboardType = .EmailAddress
        
        self.btnSave = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.btnSave.frame = CGRectMake(10, self.inputEmail.frame.origin.y + self.inputEmail.frame.height + 10, 300, 44)
        self.btnSave.setTitle("Oké!", forState: UIControlState.Normal)
        self.btnSave.hidden = true
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(self.campaignText)
        self.addSubview(self.btnContinue)
        self.addSubview(self.inputName)
        self.addSubview(self.inputEmail)
        self.addSubview(self.genderSwitch)
        self.addSubview(self.btnSave)
    }
    
    func showCredentials() {
        self.btnContinue.hidden = true
        self.campaignText.hidden = true
        
        self.inputName.hidden = false
        self.inputEmail.hidden = false
        self.genderSwitch.hidden = false
        self.btnSave.hidden = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
