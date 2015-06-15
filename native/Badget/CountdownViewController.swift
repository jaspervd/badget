//
//  CountdownViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 05/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    var timer:NSTimer = NSTimer()
    var seconds:Int = 0
    
    var countdownView:CountdownView! {
        get {
            return self.view as! CountdownView
        }
    }

    override func viewDidLoad() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerHandler:", userInfo: nil, repeats: true)
        super.viewDidLoad()
        self.title = ""
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = CountdownView(frame: bounds)
    }

    func timerHandler(timer: NSTimer) {
        self.seconds++
        let difference:Int = Int(Settings.startDate.timeIntervalSinceDate(Settings.currentDate)) - self.seconds
        
        var formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        var days:Int = difference / (60 * 60 * 24)
        var hours:Int = difference / (60 * 60) - days * 24 * 60 * 60
        var minutes:Int = difference / 60 - (hours * 60 - days * 24 * 60 * 60)
        var seconds:Int = difference - (minutes * 60 + hours * 60 * 60 + days * 24 * 60 * 60)
        
        self.countdownView.countdown.text = "Nog \(formatter.stringFromNumber(days)!) dagen, \(formatter.stringFromNumber(hours)!) uur, \(formatter.stringFromNumber(minutes)!) minuten en \(formatter.stringFromNumber(seconds)!) seconden"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
