//
//  GenderSwitch.swift
//  Badget
//
//  Created by Jasper Van Damme on 15/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Switch: UIButton {
    
    var on:Bool = false
    let thumb:UIImageView

    override init(frame: CGRect) {
        self.thumb = UIImageView(image: UIImage(named: "switchbtn"))
        self.thumb.frame.origin = CGPointMake(1.5, 1.5)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 79/255, green: 70/255, blue: 59/255, alpha: 1)
        self.layer.cornerRadius = frame.height / 2
        self.layer.masksToBounds = true
        
        self.addSubview(self.thumb)
    }
    
    func setOn(on: Bool, animated: Bool) {
        self.on = on
        if(animated) {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.thumb.frame.origin = (on ? CGPointMake(self.frame.width - 30.5, 1.5) : CGPointMake(1.5, 1.5))
            }, completion: nil)
        } else {
            self.thumb.frame.origin = (on ? CGPointMake(self.frame.width - 30.5, 1.5) : CGPointMake(1.5, 1.5))
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
