//
//  BeerkingView.swift
//  Badget
//
//  Created by Jasper Van Damme on 29/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BeerkingView: UIView {
    
    let titleText: UILabel
    let descriptionText: UITextView
    let angleText: UILabel
    let btnContinue: UIButton
    
    override init(frame: CGRect) {
        self.titleText = UILabel(frame: CGRectMake(10, 60, 300, 40))
        self.descriptionText = UITextView(frame: CGRectMake(10, 100, 300, 340))
        self.angleText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        self.btnContinue = UIButton(frame: CGRectMake(10, 440, 300, 40))
        super.init(frame: frame)
        self.backgroundColor = UIColor.grayColor()
        
        self.titleText.text = "Beerking"
        self.titleText.textAlignment = .Center
        self.descriptionText.text = "Ga naar de Randstad stand. Hier krijg je een plateau waar je jouw smartphone op moet leggen met het scherm naar beneden. Hierna zal je zo snel mogelijk en zo recht mogelijk de plateau moeten vervoeren doorheen een obstakelparcours."
        self.descriptionText.editable = false
        
        self.btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        
        self.angleText.text = "0°"
        self.angleText.textAlignment = .Center
        
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
