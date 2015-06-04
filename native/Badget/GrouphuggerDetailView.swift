//
//  GrouphuggerDetailView.swift
//  Badget
//
//  Created by Jasper Van Damme on 29/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class GrouphuggerDetailView: UIView {
    
    let titleText: UILabel
    let descriptionText: UITextView
    let btnContinue: UIButton
    
    override init(frame: CGRect) {
        self.titleText = UILabel(frame: CGRectMake(10, 60, 300, 40))
        self.descriptionText = UITextView(frame: CGRectMake(10, 100, 300, 340))
        self.btnContinue = UIButton(frame: CGRectMake(10, 440, 300, 40))
        super.init(frame: frame)
        
        self.titleText.text = "Grouphugger"
        self.titleText.textAlignment = .Center
        self.descriptionText.text = "Overtuig zoveel mogelijk mensen om mee naar de Randstad stand te gaan. Connecteer via Bluetooth met vrienden en eens bij de Randstad stand zal je score worden bepaald."
        self.descriptionText.editable = false
        
        self.btnContinue.setTitle("Let's do this!", forState: UIControlState.Normal)
        self.addSubview(self.titleText)
        self.addSubview(self.descriptionText)
        self.addSubview(self.btnContinue)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
