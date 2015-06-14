//
//  StartView.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CircularScrollView

class RegisterView: UIView {
    
    let inputName:UITextField
    let inputEmail:UITextField
    let btnSave:UIButton
    let genderSwitch:UISwitch
    
    override init(frame: CGRect) {
        self.genderSwitch = UISwitch(frame: CGRectMake(10, 400, 44, 100))
        self.genderSwitch.center = CGPointMake(frame.width / 2, self.genderSwitch.frame.origin.y)
        
        self.inputName = UITextField(frame: CGRectMake(10, self.genderSwitch.frame.origin.y + self.genderSwitch.frame.height + 10, 300, 40))
        self.inputName.placeholder = "Chokri Mahassine"
        self.inputName.autocapitalizationType = .Words
        
        self.inputEmail = UITextField(frame: CGRectMake(10, self.inputName.frame.origin.y + self.inputName.frame.height + 10, 300, 40))
        self.inputEmail.placeholder = "chokri.mahassine@pukkelpop.be"
        self.inputEmail.autocapitalizationType = .None
        self.inputEmail.keyboardType = .EmailAddress
        
        self.btnSave = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.btnSave.frame = CGRectMake(10, self.inputEmail.frame.origin.y + self.inputEmail.frame.height + 10, 300, 44)
        self.btnSave.setTitle("Oké!", forState: UIControlState.Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(self.inputName)
        self.addSubview(self.inputEmail)
        self.addSubview(self.genderSwitch)
        self.addSubview(self.btnSave)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
