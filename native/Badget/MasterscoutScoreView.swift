//
//  MasterscoutScoreView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class MasterscoutScoreView: UIView {

    let timerText:UILabel
    
    override init(frame: CGRect) {
        self.timerText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.timerText.textAlignment = .Center
        self.timerText.text = "00:00:00.00"
        
        self.addSubview(self.timerText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
