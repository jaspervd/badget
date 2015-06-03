//
//  StartView.swift
//  Badget
//
//  Created by Jasper Van Damme on 28/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class StartView: UIView {
    
    let campaignText:UITextView!
    let btnContinue:UIButton!
    let inputName:UITextField!
    let inputEmail:UITextField!
    let btnPhoto:UIButton!
    let btnSave:UIButton!
    
    override init(frame: CGRect) {
        self.campaignText = UITextView(frame: CGRect(x: 10, y: 50, width: 300, height: 400))
        self.campaignText.text = "Intro campagne"
        self.campaignText.editable = false
        
        self.btnContinue = UIButton(frame: CGRect(x: 10, y: self.campaignText.frame.origin.y + self.campaignText.frame.height + 10, width: 300, height: 40))
        self.btnContinue.setTitle("Ga verder", forState: UIControlState.Normal)
        
        self.inputName = UITextField(frame: CGRect(x: 10, y: 50, width: 300, height: 40))
        self.inputName.hidden = true
        self.inputName.placeholder = "Chokri Mahassine"
        self.inputName.autocapitalizationType = .Words
        
        self.inputEmail = UITextField(frame: CGRect(x: 10, y: self.inputName.frame.origin.y + self.inputName.frame.height + 10, width: 300, height: 40))
        self.inputEmail.hidden = true
        self.inputEmail.placeholder = "chokri.mahassine@pukkelpop.be"
        self.inputEmail.autocapitalizationType = .None
        self.inputEmail.keyboardType = .EmailAddress
        
        self.btnPhoto = UIButton(frame: CGRect(x: 10, y: self.inputEmail.frame.origin.y + self.inputEmail.frame.height + 10, width: 300, height: 40))
        self.btnPhoto.setTitle("Foto", forState: UIControlState.Normal)
        self.btnPhoto.hidden = true
        
        self.btnSave = UIButton(frame: CGRect(x: 10, y: self.btnPhoto.frame.origin.y + self.btnPhoto.frame.height + 10, width: 300, height: 40))
        self.btnSave.setTitle("Oké!", forState: UIControlState.Normal)
        self.btnSave.hidden = true
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.grayColor()
        
        self.addSubview(self.campaignText)
        self.addSubview(self.btnContinue)
        self.addSubview(self.inputName)
        self.addSubview(self.inputEmail)
        self.addSubview(self.btnPhoto)
        self.addSubview(self.btnSave)
    }
    
    func showCredentials() {
        self.btnContinue.hidden = true
        self.campaignText.hidden = true
        
        self.inputName.hidden = false
        self.inputEmail.hidden = false
        self.btnPhoto.hidden = false
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
