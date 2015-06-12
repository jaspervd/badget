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

        self.addSubview(circularScrollView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
