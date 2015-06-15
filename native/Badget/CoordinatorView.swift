//
//  CoordinatorView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CoordinatorView: UIView {
    
    let titleView:UIImageView
    let instructionText:UILabel
    let textBackground:UIImageView
    let timerText:UILabel
    let distanceText:UILabel
    let locationBg:UIImageView
    let locationText:UILabel
    let goToText:UILabel
    let countdownText:UILabel
    
    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "coordinatortitle")!)
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.instructionText = UILabel(frame: CGRectMake(0, 0, frame.width - 40, 75))
        self.instructionText.text = "Je krijgt 5 verschillende locaties die zich op de festivalweide bevinden toegewezen, ken jij het festival vanbuiten?"
        self.instructionText.font = UIFont(name: "Dosis-Bold", size: 16)
        self.instructionText.textColor = Settings.blueColor
        self.instructionText.numberOfLines = 0
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        let challengeBg = UIImageView(image: UIImage(named: "coordinatorlocatiechallengebg"))
        challengeBg.frame = CGRectMake(0, self.instructionText.frame.origin.y + self.instructionText.frame.size.height + 10, challengeBg.image!.size.width, challengeBg.image!.size.width)
        self.goToText = UILabel(frame: CGRectMake(0, challengeBg.frame.origin.y + 30, frame.width, 40))
        self.goToText.text = "Ga naar..."
        self.goToText.textAlignment = .Center
        self.goToText.textColor = UIColor.whiteColor()
        self.goToText.font = UIFont(name: "Dosis-Bold", size: 22)
        
        self.locationBg = UIImageView(image: UIImage(named: "locatiebg"))
        self.locationBg.center = CGPointMake(frame.width / 2, frame.height / 2 + 40)
        
        self.locationText = UILabel(frame: CGRectMake(0, 0, locationBg.frame.width, locationBg.frame.height))
        self.locationText.center = CGPointMake(frame.width / 2, frame.height / 2 + 40)
        self.locationText.text = "Pukkelpop"
        self.locationText.textColor = UIColor.whiteColor()
        self.locationText.font = UIFont(name: "Dosis-Bold", size: 28)
        self.locationText.textAlignment = .Center
        
        self.textBackground = UIImageView(image: UIImage(named: "afstandtijdbg"))
        self.textBackground.center = CGPointMake(frame.width / 2, (frame.height + self.locationText.frame.origin.y) / 2 + 10)
        
        self.timerText = UILabel(frame: CGRectMake(0, 0, self.textBackground.frame.width, self.textBackground.frame.height / 2))
        self.timerText.textAlignment = .Center
        self.timerText.text = "00:00:00"
        self.timerText.font = UIFont(name: "Roca", size: 22)
        self.timerText.textColor = Settings.grayColor
        
        let distanceString = "0m" as NSString
        let attString = NSMutableAttributedString(string: distanceString as String)
        attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Roca", size: 22)!, range: NSMakeRange(0, distanceString.length))
        attString.addAttribute(NSFontAttributeName, value: UIFont(name: "Roca", size: 16)!, range: NSMakeRange(distanceString.length - 1, 1))
        
        self.distanceText = UILabel(frame: CGRectMake(0, self.timerText.frame.height, self.textBackground.frame.width, self.textBackground.frame.height / 2))
        self.distanceText.textAlignment = .Center
        self.distanceText.attributedText = attString
        self.distanceText.textColor = Settings.grayColor
        
        self.countdownText = UILabel(frame: CGRectMake(0, frame.height / 2 - 10, frame.width, 200))
        self.countdownText.text = "5"
        self.countdownText.textColor = UIColor.whiteColor()
        self.countdownText.font = UIFont(name: "Dosis-Bold", size: 150)
        self.countdownText.textAlignment = .Center
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.addSubview(self.titleView)
        self.addSubview(self.instructionText)
        self.addSubview(challengeBg)
        self.addSubview(self.countdownText)
        self.textBackground.addSubview(self.timerText)
        self.textBackground.addSubview(self.distanceText)
    }
    
    func startChallenge() {
        self.countdownText.hidden = true
        self.addSubview(self.goToText)
        self.addSubview(self.locationBg)
        self.addSubview(self.locationText)
        self.addSubview(self.textBackground)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
