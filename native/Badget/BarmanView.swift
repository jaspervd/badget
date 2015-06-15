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
    let instructionText:UITextView
    let angleText:UILabel
    
    override init(frame: CGRect) {
        self.titleView = UIImageView(image: UIImage(named: "barmantitle")!)
        self.instructionText = UITextView(frame: CGRectMake(0, 0, frame.width - 40, 75))
        self.angleText = UILabel(frame: CGRectMake(0, 0, 300, 40))
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        self.instructionText.text = "Hier moet je met een plateau een parcours af te leggen. Probeer dit zo recht en zo snel mogelijk te doen."
        self.instructionText.font = UIFont.systemFontOfSize(14)
        self.instructionText.backgroundColor = UIColor.clearColor()
        self.instructionText.textAlignment = .Center
        self.instructionText.center = CGPointMake(frame.width / 2, self.titleView.frame.height * 2 + 120)
        
        let challengeBg = UIImageView(image: UIImage(named: "barmanchallengebg"))
        challengeBg.frame = CGRectMake(0, self.instructionText.frame.origin.y + self.instructionText.frame.size.height, challengeBg.image!.size.width, challengeBg.image!.size.width)
        
        let beerPlateau = UIImageView(image: UIImage(named: "barmantestplateau"))
        beerPlateau.center = CGPointMake(challengeBg.frame.width / 2, challengeBg.frame.height / 2)
        
        let testText = UITextView(frame: CGRectMake(20, 30, frame.width - 40, 50))
        testText.text = "Alvorens te beginnen kan je al eens testen hoe scheef je bent."
        testText.backgroundColor = UIColor.clearColor()
        
        self.angleText.text = "0°"
        self.angleText.font = UIFont.systemFontOfSize(16, weight: 700)
        self.angleText.textAlignment = .Center
        self.angleText.center = CGPointMake(challengeBg.frame.width / 2, challengeBg.frame.height / 2)
        
        let doneText = UITextView(frame: CGRectMake(20, beerPlateau.frame.height + beerPlateau.frame.origin.y, frame.width - 40, 50))
        doneText.text = "Wanneer je aan de beurt bent en het parcours gaat afleggen, draai je je device om met het scherm naar beneden."
        doneText.backgroundColor = UIColor.clearColor()
        
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
