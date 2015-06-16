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
    let genderSwitch:Switch
    let maleBtn:UIButton
    let femaleBtn:UIButton
    
    override init(frame: CGRect) {
        let characterBg = UIImage(named: "avatarbg")!
        self.characterView = UIView(frame: CGRectMake(0, 70, characterBg.size.width, characterBg.size.height))
        
        let characterShade = UIImageView(image: UIImage(named: "avatarshade")!)
        characterShade.center = CGPointMake(characterBg.size.width / 2, characterBg.size.height / 2)
        self.characterView.addSubview(UIImageView(image: characterBg))
        self.characterView.addSubview(characterShade)
        
        /*self.genderSwitch = UISwitch(frame: CGRectMake(10, self.characterView.frame.size.height + self.characterView.frame.origin.y, 44, 100))
        self.genderSwitch.setOn(true, animated: false)
        
        self.genderSwitch = UISwitch(frame: CGRectMake(10, self.characterView.frame.size.height + self.characterView.frame.origin.y + 10, 44, 100))
        self.genderSwitch.setOn(true, animated: false)
        self.genderSwitch.onTintColor = UIColor(red: 79/255, green: 70/255, blue: 59/255, alpha: 1)
        self.genderSwitch.tintColor = UIColor(red: 79/255, green: 70/255, blue: 59/255, alpha: 1)
        self.genderSwitch.thumbTintColor = UIColor(red: 207/255, green: 88/255, blue: 74/255, alpha: 1)*/
        
        self.genderSwitch = Switch(frame: CGRectMake((frame.width - 55) / 2, self.characterView.frame.size.height + self.characterView.frame.origin.y + 10, 55, 32))
        self.genderSwitch.setOn(true, animated: false)
        
        let maleImage = UIImage(named: "maninactive")!
        self.maleBtn = UIButton(frame: CGRectMake(self.genderSwitch.frame.origin.x + self.genderSwitch.frame.width + 10, self.genderSwitch.frame.origin.y + (self.genderSwitch.frame.height - maleImage.size.height) / 2, maleImage.size.width, maleImage.size.height))
        self.maleBtn.setBackgroundImage(maleImage, forState: .Normal)
        self.maleBtn.setBackgroundImage(UIImage(named: "manactive"), forState: .Selected)
        self.maleBtn.selected = true
        
        let femaleImage = UIImage(named: "womaninactive")!
        self.femaleBtn = UIButton(frame: CGRectMake(self.genderSwitch.frame.origin.x - femaleImage.size.width - 10, self.genderSwitch.frame.origin.y + (self.genderSwitch.frame.height - femaleImage.size.height) / 2, femaleImage.size.width, femaleImage.size.height))
        self.femaleBtn.setBackgroundImage(femaleImage, forState: .Normal)
        self.femaleBtn.setBackgroundImage(UIImage(named: "womanactive"), forState: .Selected)
        

        let inputView = UIView(frame: CGRectMake((frame.size.width - 294) / 2, self.genderSwitch.frame.origin.y + self.genderSwitch.frame.height + 10, 294, 93))
        inputView.addSubview(UIImageView(image: UIImage(named: "loginput")))
        
        self.inputName = UITextField(frame: CGRectMake(15, 2, inputView.frame.size.width - 30, 45))
        self.inputName.placeholder = "Chokri Mahassine"
        self.inputName.autocapitalizationType = .Words
        self.inputName.font = UIFont(name: "Dosis-Medium", size: 20)
        
        self.inputEmail = UITextField(frame: CGRectMake(15, 47, inputView.frame.size.width - 30, 45))
        self.inputEmail.placeholder = "chokri.mahassine@pukkelpop.be"
        self.inputEmail.autocapitalizationType = .None
        self.inputEmail.keyboardType = .EmailAddress
        self.inputEmail.font = UIFont(name: "Dosis-Medium", size: 20)
        
        self.btnSave = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.btnSave.frame = CGRectMake((frame.size.width - 252) / 2, inputView.frame.origin.y + inputView.frame.height + 14, 252, 53)
        self.btnSave.setBackgroundImage(UIImage(named: "loginbtn"), forState: .Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(inputView)
        self.addSubview(self.characterView)
        inputView.addSubview(self.inputName)
        inputView.addSubview(self.inputEmail)
        self.addSubview(self.genderSwitch)
        self.addSubview(self.maleBtn)
        self.addSubview(self.femaleBtn)
        self.addSubview(self.btnSave)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
