//
//  CharacterPartViewController.swift
//  Badget
//
//  Created by Jasper Van Damme on 13/06/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit

class CharacterPartViewController: UIViewController {
    
    let maleArray:Array<UIImage>
    let femaleArray:Array<UIImage>
    var activeArray:Array<UIImage>
    var currentIndex:Int = 0
    let partsCount:Int
    
    var characterPartView:CharacterPartView! {
        get {
            return self.view as! CharacterPartView
        }
    }
    
    init(maleArray: Array<UIImage>, femaleArray: Array<UIImage>) {
        self.maleArray = maleArray
        self.femaleArray = femaleArray
        self.activeArray = self.maleArray
        self.partsCount = maleArray.count
        super.init(nibName: nil, bundle: nil)
        
        if(self.maleArray.count != self.femaleArray.count) {
            fatalError("Body parts are not equal")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.characterPartView.imageView.image = self.femaleArray[0]
        
        self.characterPartView.leftBtn.addTarget(self, action: "leftBtnHandler", forControlEvents: UIControlEvents.TouchUpInside)
        self.characterPartView.rightBtn.addTarget(self, action: "rightBtnHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func leftBtnHandler() {
        var newIndex = self.partsCount - 1
        if(currentIndex > 0) {
            currentIndex--
            newIndex = currentIndex
        } else {
            currentIndex = newIndex
        }
        println(newIndex)
        self.characterPartView.imageView.image = self.activeArray[newIndex]
    }
    
    func rightBtnHandler() {
        var newIndex = 0
        if(currentIndex < (self.partsCount - 1)) {
            currentIndex++
            newIndex = currentIndex
        } else {
            currentIndex = newIndex
        }
        println(newIndex)
        self.characterPartView.imageView.image = self.activeArray[newIndex]
    }
    
    func switchActiveArray() {
        if(self.activeArray == self.maleArray) {
            self.activeArray = self.femaleArray
        } else {
            self.activeArray = self.maleArray
        }
    }
    
    override func loadView() {
        let bounds = UIScreen.mainScreen().bounds
        self.view = CharacterPartView(frame: CGRectMake(0, 0, bounds.width, self.femaleArray[0].size.height), partSize: self.femaleArray[0].size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
