//
//  BeerkingVisualView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BeerkingVisualView: UIView {

    let angleText: UILabel
    
    override init(frame: CGRect) {
        self.angleText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.angleText.text = "0°"
        self.angleText.textAlignment = .Center
        
        self.addSubview(self.angleText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
