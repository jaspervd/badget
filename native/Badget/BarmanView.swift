//
//  BarmanView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BarmanView: UIView {

    let titleView:UIImageView
    let instructionText:UITextView
    let angleText:UILabel
    
    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "barmantitle")!)
        self.instructionText = UITextView(frame: CGRectMake(0, 0, frame.width - 40, 75))
        self.angleText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        self.instructionText.text = "Hier moet je met een plateau een parcours af te leggen. Probeer dit zo recht en zo snel mogelijk te doen."
        self.instructionText.font = UIFont.systemFontOfSize(14)
        self.instructionText.backgroundColor = UIColor.clearColor()
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        self.angleText.text = "0°"
        self.angleText.textAlignment = .Center
        
        self.addSubview(self.titleView)
        self.addSubview(self.instructionText)
        self.addSubview(self.angleText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
