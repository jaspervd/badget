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
    
    let characterView:UIView
    let inputName:UITextField
    let inputEmail:UITextField
    let btnSave:UIButton
    let genderSwitch:UISwitch
    
    override init(frame: CGRect) {
        let characterBg = UIImage(named: "avatarbg")!
        self.characterView = UIView(frame: CGRectMake(0, 40, characterBg.size.width, characterBg.size.height))
        
        let characterShade = UIImageView(image: UIImage(named: "avatarshade")!)
        characterShade.center = CGPointMake(characterBg.size.width / 2, characterBg.size.height / 2)
        self.characterView.addSubview(UIImageView(image: characterBg))
        self.characterView.addSubview(characterShade)
        
        self.genderSwitch = UISwitch(frame: CGRectMake(10, self.characterView.frame.size.height + self.characterView.frame.origin.y, 44, 100))
        
        let inputView = UIView(frame: CGRectMake((frame.size.width - 294) / 2, self.genderSwitch.frame.origin.y + self.genderSwitch.frame.height, 294, 93))
        inputView.addSubview(UIImageView(image: UIImage(named: "loginput")))
        
        self.inputName = UITextField(frame: CGRectMake(15, 2, inputView.frame.size.width - 30, 45))
        self.inputName.placeholder = "Chokri Mahassine"
        self.inputName.autocapitalizationType = .Words
        
        self.inputEmail = UITextField(frame: CGRectMake(15, 47, inputView.frame.size.width - 30, 45))
        self.inputEmail.placeholder = "chokri.mahassine@pukkelpop.be"
        self.inputEmail.autocapitalizationType = .None
        self.inputEmail.keyboardType = .EmailAddress
        
        self.btnSave = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.btnSave.frame = CGRectMake((frame.size.width - 252) / 2, inputView.frame.origin.y + inputView.frame.height + 10, 252, 53)
        self.btnSave.setBackgroundImage(UIImage(named: "loginbtn"), forState: .Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(inputView)
        self.addSubview(self.characterView)
        inputView.addSubview(self.inputName)
        inputView.addSubview(self.inputEmail)
        self.addSubview(self.genderSwitch)
        self.addSubview(self.btnSave)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
