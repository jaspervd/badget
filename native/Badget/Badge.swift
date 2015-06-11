//
//  Badge.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Badge: NSObject {
    let title:String
    let goal:String
    let image:UIImage
    
    init(title: String, goal: String, image: UIImage) {
        self.title = title
        self.goal = goal
        self.image = image
        super.init()
    }
}
