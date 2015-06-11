//
//  InstructionView.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class InstructionView: UIView {
    
    let instructionTextView:UITextView
    let btnContinue:UIButton

    override init(frame: CGRect) {
        self.instructionTextView = UITextView(frame: CGRectMake(20, 20, frame.size.width - 40, 200))
        self.btnContinue = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.instructionTextView.text = "Ga naar de Randstad stand"
        self.instructionTextView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        self.instructionTextView.backgroundColor = nil
        self.instructionTextView.textAlignment = .Center
        self.instructionTextView.editable = false
        
        self.btnContinue.frame = CGRectMake(20, self.instructionTextView.frame.origin.x + self.instructionTextView.frame.size.height, frame.size.width - 40, 44)
        self.btnContinue.setTitle("Oké, ik ben er!", forState: UIControlState.Normal)
        self.btnContinue.setTitleColor(UIColor(white: 1, alpha: 0.5), forState: UIControlState.Disabled)
        self.btnContinue.enabled = false
        
        self.addSubview(self.instructionTextView)
        self.addSubview(self.btnContinue)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
