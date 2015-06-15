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
    
    /*
    - (void)initialize {
    
    [self setTransform:CGAffineTransformMakeTranslation(0, -(VFSNavigationBarHeightIncrease))];
    }

*/
    
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
            if(find(classNames, NSStringFromClass(view.classForCoder)) != nil) {
                if let usingView = view as? UIView {
                    var newFrame = usingView.frame
                    newFrame.origin.y = self.bounds.origin.y + addHeight - 20
                    newFrame.size.height = bounds.size.height + 20
                    usingView.frame = newFrame
                }
            }
        }
    }
    /*
NSArray *classNamesToReposition = @[@"_UINavigationBarBackground"];

for (UIView *view in [self subviews]) {

if ([classNamesToReposition containsObject:NSStringFromClass([view class])]) {

CGRect bounds = [self bounds];
CGRect frame = [view frame];
frame.origin.y = bounds.origin.y + VFSNavigationBarHeightIncrease - 20.f;
frame.size.height = bounds.size.height + 20.f;

[view setFrame:frame];
}
}
*/
}
