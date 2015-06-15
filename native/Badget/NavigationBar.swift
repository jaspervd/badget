//
//  NavigationBar.swift
//  Badget
//
//  Created by Jasper Van Damme on 15/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    let addHeight:CGFloat = 31.0

    override func sizeThatFits(size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height += addHeight
        return newSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let classNames:Array<String> = ["UINavigationButton"]
        for view in self.subviews {
            if(find(classNames, NSStringFromClass(view.classForCoder)) != nil) {
                var newFrame = view.frame
                newFrame.origin.y -= addHeight
                if var frame = view.frame {
                    frame = newFrame
                }
            }
        }
    }
}
