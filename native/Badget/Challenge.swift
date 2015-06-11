//
//  Challenge.swift
//  Badget
//
//  Created by Jasper Van Damme on 11/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class Challenge: NSObject {
    let title:String
    let viewController:ChallengeProtocol
    let intro:String
    let image:UIImage
    
    init(title: String, viewController: ChallengeProtocol, intro: String, image: UIImage) {
        self.title = title
        self.viewController = viewController
        self.intro = intro
        self.image = image
        super.init()
    }
}
