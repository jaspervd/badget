//
//  BarmanView.swift
//  Badget
//
//  Created by Jasper Van Damme on 04/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class BarmanView: UIView {

    let titleView:UIImageView
    let instructionText:UILabel
    let angleText:UILabel
    
    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "barmantitle")!)
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        self.instructionText = UILabel(frame: CGRectMake(0, 0, frame.width - 40, 75))
        self.instructionText.text = "Hier moet je met een plateau een parcours af te leggen. Probeer dit zo recht en zo snel mogelijk te doen."
        self.instructionText.font = UIFont(name: "Dosis-Bold", size: 16)
        self.instructionText.textColor = Settings.blueColor
        self.instructionText.numberOfLines = 0
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        let challengeBg = UIImageView(image: UIImage(named: "barmanchallengebg"))
        challengeBg.frame = CGRectMake(0, self.instructionText.frame.origin.y + self.instructionText.frame.size.height + 10, challengeBg.image!.size.width, challengeBg.image!.size.width)
        
        let beerPlateau = UIImageView(image: UIImage(named: "barmantestplateau"))
        beerPlateau.center = CGPointMake(challengeBg.frame.width / 2, challengeBg.frame.height / 2 - 10)
        
        let testText = UILabel(frame: CGRectMake(20, 30, frame.width - 40, 50))
        testText.text = "Voordat je begint kan je al testen hoe recht je je smartphone kan houden."
        testText.numberOfLines = 0
        testText.font = UIFont(name: "Dosis-Medium", size: 18)
        testText.textColor = UIColor.whiteColor()
        testText.textAlignment = .Center
        //testText.sizeToFit()
        
        self.angleText = UILabel(frame: CGRectMake(0, 0, 300, 40))
        self.angleText.text = "0°"
        self.angleText.font = UIFont(name: "Dosis-Bold", size: 24)
        self.angleText.textColor = Settings.grayColor
        self.angleText.textAlignment = .Center
        self.angleText.center = CGPointMake(challengeBg.frame.width / 2 + 5, challengeBg.frame.height / 2 - 13)
        
        let doneText = UILabel(frame: CGRectMake(20, beerPlateau.frame.height + beerPlateau.frame.origin.y + 10, frame.width - 40, 50))
        doneText.text = "Wanneer je aan de beurt bent en het parcours gaat afleggen, draai je je device om met het scherm naar beneden."
        doneText.numberOfLines = 0
        doneText.textAlignment = .Center
        doneText.font = UIFont(name: "Dosis-Medium", size: 18)
        doneText.textColor = UIColor.whiteColor()
        doneText.sizeToFit()
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.addSubview(self.titleView)
        self.addSubview(self.instructionText)
        self.addSubview(challengeBg)
        challengeBg.addSubview(testText)
        challengeBg.addSubview(beerPlateau)
        challengeBg.addSubview(doneText)
        challengeBg.addSubview(self.angleText)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
