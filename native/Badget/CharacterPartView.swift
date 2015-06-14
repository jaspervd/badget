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
    let leftBtn:ArrowButton
    let rightBtn:ArrowButton

    init(frame: CGRect, partSize: CGSize) {
        self.imageView = UIImageView(frame: CGRectMake((frame.width - partSize.width) / 2, 0, partSize.width, partSize.height))
        self.leftBtn = ArrowButton(frame: CGRectMake(10, partSize.height / 2 - 22, 30, 44))
        self.leftBtn.setDirection(.Left)
        
        self.rightBtn = ArrowButton(frame: CGRectMake(frame.width - 40, partSize.height / 2 - 22, 30, 44))
        self.rightBtn.setDirection(.Right)
        
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
