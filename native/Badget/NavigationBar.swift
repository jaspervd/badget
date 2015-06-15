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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.transform = CGAffineTransformMakeTranslation(0, -addHeight)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height += addHeight
        return newSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let classNames:Array<String> = ["_UINavigationBarBackground"]
        for view in self.subviews {
            if let thisView = view as? UIView {
                var newFrame = thisView.frame
                if(NSStringFromClass(view.classForCoder) == "_UINavigationBarBackground") {
                    newFrame.origin.y = self.bounds.origin.y + addHeight - 20
                    newFrame.size.height = self.bounds.size.height + 20
                    thisView.frame = newFrame
                } else if(NSStringFromClass(view.classForCoder) == "UINavigationButton") {
                    newFrame.origin.y = 35
                    thisView.frame = newFrame
                } else if(NSStringFromClass(view.classForCoder) == "_UINavigationBarBackIndicatorView") {
                    newFrame.origin.x = 15.5
                    newFrame.origin.y = 34
                    thisView.frame = newFrame
                }
            }
        }
    }
}
