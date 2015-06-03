//
//  MasterscoutView.swift
//  Badget
//
//  Created by Jasper Van Damme on 29/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import MapKit

class MasterscoutView: UIView {
    
    let titleText: UILabel
    let descriptionText: UITextView
    let btnContinue:UIButton
    let timerText:UILabel
    let instructionText:UILabel
    
    override init(frame: CGRect) {
        self.titleText = UILabel(frame: CGRectMake(10, 60, 300, 40))
        self.descriptionText = UITextView(frame: CGRectMake(10, 100, 300, 340))
        self.btnContinue = UIButton(frame: CGRectMake(10, 440, 300, 40))
        self.instructionText = UILabel(frame: CGRectMake(10, 240, 300, 30))
        self.timerText = UILabel(frame: CGRectMake(10, 300, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.redColor()
        
        self.titleText.text = "Masterscout"
        self.titleText.textAlignment = .Center
        self.descriptionText.text = "Vanaf de Randstad stand zal je een parcours moeten afleggen, doe dit zo efficiënt en zo snel mogelijk. Je moet het terrein van binnen en van buiten leren kennen."
        self.descriptionText.editable = false
        
        self.instructionText.textAlignment = .Center
        self.instructionText.textColor = UIColor.whiteColor()
        self.instructionText.font = UIFont.systemFontOfSize(25)
        
        self.timerText.textAlignment = .Center
        self.timerText.text = "00:00:00.00"
        
        self.btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        self.addSubview(self.titleText)
        self.addSubview(self.descriptionText)
        self.addSubview(self.btnContinue)
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
