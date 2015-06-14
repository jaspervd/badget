//
//  LeftButton.swift
//  Badget
//
//  Created by Jasper Van Damme on 14/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class ArrowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setDirection(direction: Direction) {
        switch direction {
        case .Left:
            self.setBackgroundImage(UIImage(named: "avatarbtnleft"), forState: .Normal)
        case .Right:
            self.setBackgroundImage(UIImage(named: "avatarbtnright"), forState: .Normal)
        default:
            self.setBackgroundImage(UIImage(named: "avatarbtnleft"), forState: .Normal)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    enum Direction {
        case Left
        case Right
    }
}
