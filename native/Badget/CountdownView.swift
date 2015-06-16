//
//  CountdownView.swift
//  Badget
//
//  Created by Jasper Van Damme on 05/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CountdownView: UIView {
    
    let countdownDays:UILabel!
    let countdownHours:UILabel!
    let countdownMinutes:UILabel!
    let countdownSeconds:UILabel!
    
    override init(frame: CGRect) {
        let font = UIFont(name: "Roca", size: 22)
        let hand = UIImageView(image: UIImage(named: "hand"))
        hand.frame.origin = CGPointMake((frame.width - hand.frame.width) / 2, frame.height - hand.frame.height + 120)
        
        let countdownView = UIImageView(image: UIImage(named: "clock"))
        countdownView.frame.origin = CGPointMake((frame.width - countdownView.frame.width) / 2, 300)
        
        self.countdownDays = UILabel(frame: CGRectMake(5, 14, 50, 60))
        self.countdownDays.text = ""
        self.countdownDays.font = font
        self.countdownDays.textColor = Settings.redColor
        self.countdownDays.textAlignment = .Center
        
        let days = UILabel(frame: CGRectMake(5, 35, 50, 20))
        days.text = "dagen"
        days.font = UIFont(name: "Dosis-Medium", size: 12)
        days.textColor = Settings.blueColor
        days.textAlignment = .Center
        
        self.countdownHours = UILabel(frame: CGRectMake(70, 14, 50, 60))
        self.countdownHours.text = ""
        self.countdownHours.font = font
        self.countdownHours.textColor = Settings.redColor
        self.countdownHours.textAlignment = .Center
        
        let hours = UILabel(frame: CGRectMake(70, 35, 50, 20))
        hours.text = "uren"
        hours.font = UIFont(name: "Dosis-Medium", size: 12)
        hours.textColor = Settings.blueColor
        hours.textAlignment = .Center
        
        self.countdownMinutes = UILabel(frame: CGRectMake(130, 14, 50, 60))
        self.countdownMinutes.text = ""
        self.countdownMinutes.font = font
        self.countdownMinutes.textColor = Settings.redColor
        self.countdownMinutes.textAlignment = .Center
        
        let minutes = UILabel(frame: CGRectMake(130, 35, 50, 20))
        minutes.text = "minuten"
        minutes.font = UIFont(name: "Dosis-Medium", size: 12)
        minutes.textColor = Settings.blueColor
        minutes.textAlignment = .Center
        
        self.countdownSeconds = UILabel(frame: CGRectMake(190, 14, 50, 60))
        self.countdownSeconds.text = ""
        self.countdownSeconds.font = font
        self.countdownSeconds.textColor = Settings.redColor
        self.countdownSeconds.textAlignment = .Center
        
        let seconds = UILabel(frame: CGRectMake(190, 35, 50, 20))
        seconds.text = "seconden"
        seconds.font = UIFont(name: "Dosis-Medium", size: 12)
        seconds.textColor = Settings.blueColor
        seconds.textAlignment = .Center
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(hand)
        self.addSubview(countdownView)
        countdownView.addSubview(self.countdownDays)
        countdownView.addSubview(days)
        countdownView.addSubview(self.countdownHours)
        countdownView.addSubview(hours)
        countdownView.addSubview(self.countdownMinutes)
        countdownView.addSubview(minutes)
        countdownView.addSubview(self.countdownSeconds)
        countdownView.addSubview(seconds)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
