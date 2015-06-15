//
//  CoordinatorView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CoordinatorView: UIView {
    
    let titleView:UIImageView
    let instructionText:UITextView
    let timerText:UILabel
    
    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "coordinatortitle")!)
        self.instructionText = UITextView(frame: CGRectMake(0, 0, frame.width - 40, 75))
        self.timerText = UILabel(frame: CGRectMake(10, 300, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.instructionText.text = "Je krijgt 5 verschillende locaties die zich op de festivalweide bevinden toegewezen, eens je op een locatie bent wordt je gestuurd naar de volgende plek."
        self.instructionText.font = UIFont.systemFontOfSize(14)
        self.instructionText.backgroundColor = UIColor.clearColor()
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        self.timerText.textAlignment = .Center
        self.timerText.text = "00:00:00.00"
        
        self.addSubview(self.titleView)
        self.addSubview(self.instructionText)
        self.addSubview(self.timerText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
