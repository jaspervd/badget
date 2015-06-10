//
//  CountdownView.swift
//  Badget
//
//  Created by Jasper Van Damme on 05/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CountdownView: UIView {

    let countdown:UILabel!
    
    override init(frame: CGRect) {
        self.countdown = UILabel(frame: CGRectMake(10, 60, 300, 40))
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.countdown.text = ""
        self.countdown.textAlignment = .Center
        self.countdown.font = UIFont.systemFontOfSize(10)
        self.countdown.textColor = UIColor.whiteColor()
        
        self.addSubview(self.countdown)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
