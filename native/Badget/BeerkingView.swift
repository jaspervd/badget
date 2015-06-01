//
//  BeerkingView.swift
//  Badget
//
//  Created by Jasper Van Damme on 29/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BeerkingView: UIView {
    
    let angleText: UILabel
    let btnContinue: UIButton
    
    override init(frame: CGRect) {
        self.angleText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        self.btnContinue = UIButton(frame: CGRectMake(10, 440, 300, 40))
        super.init(frame: frame)
        self.backgroundColor = UIColor.grayColor()
        
        self.btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        
        self.angleText.text = "0°"
        self.angleText.textAlignment = .Center
        self.angleText.hidden = true
        
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
