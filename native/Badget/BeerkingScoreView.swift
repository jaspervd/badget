//
//  BeerkingScoreView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BeerkingScoreView: UIView {
    
    let angleText: UILabel
    let timeText: UILabel
    
    override init(frame: CGRect) {
        self.angleText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        self.timeText = UILabel(frame: CGRectMake(10, self.angleText.frame.origin.y + 40, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.angleText.text = "Gemiddelde: 0°"
        self.angleText.textAlignment = .Center
        
        self.timeText.text = "0 seconden"
        self.timeText.textAlignment = .Center
        
        self.addSubview(self.angleText)
        self.addSubview(self.timeText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
