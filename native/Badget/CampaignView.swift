//
//  CampaignView.swift
//  Badget
//
//  Created by Jasper Van Damme on 14/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CampaignView: UIView {

    let btnContinue:UIButton
    let titleView:UIImageView
    
    override init(frame: CGRect) {
        let bgImage = UIImageView(image: UIImage(named: "infocampagnebg"))
        bgImage.frame.origin = CGPointMake(0, frame.height - bgImage.frame.height)
        self.titleView = UIImageView(image: UIImage(named: "infotitle")!)
        self.titleView.center = CGPointMake(frame.width / 2, self.titleView.frame.height / 2 + 110)
        
        let fontMedium = UIFont(name: "Dosis-Medium", size: 16)!
        let fontBold = UIFont(name: "Dosis-Bold", size: 16)!
        let line = UIImageView(image: UIImage(named: "lijn"))
        let secondLine = UIImageView(image: UIImage(named: "lijn"))
        
        let randstadString = "Randstad wilt festivalgangers een mooie tijd laten beleven, maar dit is niet voor niets." as NSString
        let randstadAtt = NSMutableAttributedString(string: randstadString as String)

        randstadAtt.addAttribute(NSFontAttributeName, value: fontMedium, range: NSMakeRange(0, randstadString.length))
        randstadAtt.addAttribute(NSFontAttributeName, value: fontBold, range: randstadString.rangeOfString("Randstad"))
        randstadAtt.addAttribute(NSFontAttributeName, value: fontBold, range: randstadString.rangeOfString("festivalgangers"))
        randstadAtt.addAttribute(NSFontAttributeName, value: fontBold, range: randstadString.rangeOfString("niet voor niets"))
        
        let textRandstad = UILabel(frame: CGRectMake(50, self.titleView.frame.origin.y, frame.width - 100, 150))
        textRandstad.textColor = Settings.grayColor
        textRandstad.attributedText = randstadAtt
        textRandstad.numberOfLines = 0
        textRandstad.textAlignment = .Center
        
        let challengesString = "Je moet eerst hun 3 uitdagingen uitvoeren, wie het beste presteert maakt het meeste kans.\n\nDeze kan je elke dag uitvoeren om zo jouw kans te vergroten!" as NSString
        let challengesAtt = NSMutableAttributedString(string: challengesString as String)
        
        challengesAtt.addAttribute(NSFontAttributeName, value: fontMedium, range: NSMakeRange(0, challengesString.length))
        challengesAtt.addAttribute(NSFontAttributeName, value: fontBold, range: challengesString.rangeOfString("3 uitdagingen"))
        challengesAtt.addAttribute(NSFontAttributeName, value: fontBold, range: challengesString.rangeOfString("beste presteert"))
        challengesAtt.addAttribute(NSFontAttributeName, value: fontBold, range: challengesString.rangeOfString("meeste kans"))
        challengesAtt.addAttribute(NSFontAttributeName, value: fontBold, range: challengesString.rangeOfString("elke dag"))
        challengesAtt.addAttribute(NSFontAttributeName, value: fontBold, range: challengesString.rangeOfString("vergroten"))
        
        let textChallenges = UILabel(frame: CGRectMake(50, self.titleView.frame.origin.y + textRandstad.frame.origin.y + 20, frame.width - 100, 150))
        textChallenges.textColor = Settings.grayColor
        textChallenges.attributedText = challengesAtt
        textChallenges.numberOfLines = 0
        textChallenges.textAlignment = .Center
        textChallenges.sizeToFit()
        
        let jobString = "Op het einde van de dag mag je backstage gaan werken en de artiesten voorzien van sfeer, gezelligheid, drank en stiptheid!" as NSString
        let jobAtt = NSMutableAttributedString(string: jobString as String)
        
        jobAtt.addAttribute(NSFontAttributeName, value: fontMedium, range: NSMakeRange(0, jobString.length))
        jobAtt.addAttribute(NSFontAttributeName, value: fontBold, range: jobString.rangeOfString("einde van de dag"))
        jobAtt.addAttribute(NSFontAttributeName, value: fontBold, range: jobString.rangeOfString("backstage gaan werken"))
        jobAtt.addAttribute(NSFontAttributeName, value: fontBold, range: jobString.rangeOfString("artiesten voorzien van sfeer, gezelligheid, drank en stiptheid!"))
        
        let textJob = UILabel(frame: CGRectMake(50, self.titleView.frame.origin.y + textChallenges.frame.origin.y + 5, frame.width - 100, 150))
        textJob.textColor = Settings.grayColor
        textJob.attributedText = jobAtt
        textJob.numberOfLines = 0
        textJob.textAlignment = .Center
        
        line.frame.origin = CGPointMake((frame.width - line.frame.size.width) / 2, self.titleView.frame.origin.y + textRandstad.frame.origin.y + 8)
        secondLine.frame.origin = CGPointMake((frame.width - line.frame.size.width) / 2, self.titleView.frame.origin.y + textChallenges.frame.origin.y + 26)
        
        let btnImage = UIImage(named: "okbtn")!
        self.btnContinue = UIButton(frame: CGRectMake((frame.width - btnImage.size.width) / 2, frame.size.height - btnImage.size.height - 30, btnImage.size.width, btnImage.size.height))
        self.btnContinue.setBackgroundImage(btnImage, forState: UIControlState.Normal)
        
        super.init(frame: frame)
        
        self.backgroundColor = Settings.bgColor
        self.addSubview(bgImage)
        self.addSubview(self.titleView)
        self.addSubview(self.btnContinue)
        self.addSubview(textRandstad)
        self.addSubview(textChallenges)
        self.addSubview(textJob)
        self.addSubview(line)
        self.addSubview(secondLine)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
