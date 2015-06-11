//
//  MasterscoutVisualView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class MasterscoutView: UIView {
    
    let timerText:UILabel
    let instructionText:UILabel
    
    override init(frame: CGRect) {
        self.instructionText = UILabel(frame: CGRectMake(10, 240, 300, 30))
        self.timerText = UILabel(frame: CGRectMake(10, 300, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.instructionText.textAlignment = .Center
        self.instructionText.textColor = UIColor.whiteColor()
        self.instructionText.font = UIFont.systemFontOfSize(25)
        
        self.timerText.textAlignment = .Center
        self.timerText.text = "00:00:00.00"
        
        self.addSubview(self.instructionText)
        self.addSubview(self.timerText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
