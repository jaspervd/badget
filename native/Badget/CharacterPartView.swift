//
//  CharacterPartView.swift
//  Badget
//
//  Created by Jasper Van Damme on 13/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CharacterPartView: UIView {
    
    let imageView:UIImageView
    let leftBtn:UIButton
    let rightBtn:UIButton

    init(frame: CGRect, partSize: CGSize) {
        self.imageView = UIImageView(frame: CGRectMake((frame.width - partSize.width) / 2, 0, partSize.width, partSize.height))
        self.leftBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        self.rightBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        super.init(frame: frame)
        
        self.imageView.backgroundColor = UIColor.redColor()
        
        self.leftBtn.frame = CGRectMake(10, partSize.height / 2 - 22, 30, 44)
        self.leftBtn.setTitle("<", forState: UIControlState.Normal)
        self.leftBtn.backgroundColor = UIColor.whiteColor()
        
        self.rightBtn.frame = CGRectMake(frame.width - 40, partSize.height / 2 - 22, 30, 44)
        self.rightBtn.setTitle(">", forState: UIControlState.Normal)
        self.rightBtn.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(self.imageView)
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
