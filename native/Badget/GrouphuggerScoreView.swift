//
//  GrouphuggerScoreView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class GrouphuggerScoreView: UIView {

    let friendsText:UILabel
    
    override init(frame: CGRect) {
        self.friendsText = UILabel(frame: CGRectMake(10, frame.height / 2, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.friendsText.textAlignment = .Center
        self.friendsText.text = "0 vrienden"
        
        self.addSubview(self.friendsText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
