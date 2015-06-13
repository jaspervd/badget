//
//  ChallengesView.swift
//  Badget
//
//  Created by Jasper Van Damme on 12/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CircularScrollView

class ChallengesView: UIView {

    let circularScrollView:CircularScrollView
    
    override init(frame: CGRect) {
        self.circularScrollView = CircularScrollView(frame: frame)
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.circularScrollView.backgroundColor = nil
        
        let infoText = UITextView(frame: CGRectMake(20, frame.height - 80, frame.width - 40, 80))
        infoText.backgroundColor = nil
        infoText.editable = false
        infoText.textColor = UIColor.whiteColor()
        infoText.text = "Ga naar de Randstad stand om de uitdaging aan te gaan."

        self.addSubview(circularScrollView)
        self.addSubview(infoText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
