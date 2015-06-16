//
//  InfoView.swift
//  Badget
//
//  Created by Jasper Van Damme on 16/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class InfoView: UIView {
    
    let titleView:UIImageView

    override init(frame: CGRect) {
        let bgImage = UIImageView(image: UIImage(named: "infocampagnebg"))
        bgImage.frame.origin = CGPointMake(0, frame.height - bgImage.frame.height)
        self.titleView = UIImageView(image: UIImage(named: "infotitle")!)
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        let steps = UIImageView(image: UIImage(named: "stappen")!)
        steps.center = CGPointMake(frame.width / 2, (frame.height + self.titleView.frame.origin.y) / 2)
        
        let font = UIFont(name: "Dosis-Bold", size: 20)
        
        let standText = UILabel(frame: CGRectMake(30, steps.frame.origin.y, 100, 70))
        standText.text = "Ga naar onze stand"
        standText.textColor = Settings.grayColor
        standText.font = font
        standText.numberOfLines = 0
        standText.textAlignment = .Right
        standText.sizeToFit()
        standText.alpha = 0
        
        let standImage = UIImageView(image: UIImage(named: "randstadstand"))
        standImage.frame.origin = CGPointMake(frame.width - standImage.frame.size.width - 30, steps.frame.origin.y)
        standImage.alpha = 0
        
        let chooseText = UILabel(frame: CGRectMake(frame.width - 130, steps.frame.origin.y + 90, 100, 70))
        chooseText.text = "Kies een uitdaging"
        chooseText.textColor = Settings.grayColor
        chooseText.font = font
        chooseText.numberOfLines = 0
        chooseText.sizeToFit()
        chooseText.alpha = 0
        
        let chooseImage = UIImageView(image: UIImage(named: "uitdagingenscaled"))
        chooseImage.frame.origin = CGPointMake(14, steps.frame.origin.y + 88)
        chooseImage.alpha = 0
        
        let dailyText = UILabel(frame: CGRectMake(20, chooseText.frame.origin.y + 90, 100, 70))
        dailyText.text = "Voer deze dagelijks uit"
        dailyText.textColor = Settings.grayColor
        dailyText.font = font
        dailyText.numberOfLines = 0
        dailyText.textAlignment = .Right
        dailyText.sizeToFit()
        dailyText.alpha = 0
        
        let dailyImage = UIImageView(image: UIImage(named: "kalender"))
        dailyImage.frame.origin = CGPointMake(frame.width - dailyImage.frame.size.width - 20, chooseText.frame.origin.y + 90)
        dailyImage.alpha = 0
        
        let badgesText = UILabel(frame: CGRectMake(frame.width - 130, dailyText.frame.origin.y + 90, 110, 130))
        badgesText.text = "Win badges en maak kans op de job!"
        badgesText.textColor = Settings.grayColor
        badgesText.font = font
        badgesText.numberOfLines = 0
        badgesText.sizeToFit()
        badgesText.alpha = 0
        
        let badgesImage = UIImageView(image: UIImage(named: "badgesscaled"))
        badgesImage.frame.origin = CGPointMake(20, dailyText.frame.origin.y + 90)
        badgesImage.alpha = 0
        
        UIView.animateWithDuration(1.5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            standText.alpha = 1
            standImage.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 1.5, options: .CurveEaseInOut, animations: { () -> Void in
            chooseText.alpha = 1
            chooseImage.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 3, options: .CurveEaseInOut, animations: { () -> Void in
            dailyText.alpha = 1
            dailyImage.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 4.5, options: .CurveEaseInOut, animations: { () -> Void in
            badgesText.alpha = 1
            badgesImage.alpha = 1
            }, completion: nil)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.addSubview(bgImage)
        self.addSubview(self.titleView)
        self.addSubview(steps)
        self.addSubview(standText)
        self.addSubview(standImage)
        self.addSubview(chooseText)
        self.addSubview(chooseImage)
        self.addSubview(dailyText)
        self.addSubview(dailyImage)
        self.addSubview(badgesText)
        self.addSubview(badgesImage)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
