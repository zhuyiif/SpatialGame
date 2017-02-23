//
//  DiceView.swift
//  spatial
//
//  Created by yi zhu on 2/22/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let DICE_VIEW_MARGIN_RATIO = 0.1 // 10% margin
}


class DiceView: UIView {
    
    var topImageView: UIImageView
    var bottomImageView: UIImageView
    var frontImageView: UIImageView
    var backImageView: UIImageView
    var rightImageView: UIImageView
    var leftImageView: UIImageView
    
    override init(frame: CGRect) {
        
        let screenWidth = frame.width
        let diceViewWidth = screenWidth * (1 - (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO * 2))
        let diceSize = (Int) (diceViewWidth/5)
        let margin = (Int) (screenWidth * (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO))
        
        self.leftImageView = UIImageView(frame: CGRect(x: margin, y: margin + diceSize, width: diceSize, height: diceSize))
        self.bottomImageView = UIImageView(frame: CGRect(x: margin + diceSize, y: margin + diceSize, width: diceSize, height: diceSize))
        self.rightImageView = UIImageView(frame: CGRect(x: margin + diceSize * 2, y: margin + diceSize, width: diceSize, height: diceSize))
        self.topImageView = UIImageView(frame: CGRect(x: margin + diceSize * 3, y: margin + diceSize, width: diceSize, height: diceSize))
        
        self.backImageView = UIImageView(frame: CGRect(x: margin + diceSize , y: margin , width: diceSize, height: diceSize))
        self.frontImageView = UIImageView(frame: CGRect(x: margin + diceSize , y: margin + diceSize * 2 , width: diceSize, height: diceSize))
        
        self.leftImageView.backgroundColor = UIColor.red
        self.bottomImageView.backgroundColor = UIColor.yellow
        self.rightImageView.backgroundColor = UIColor.blue
        self.topImageView.backgroundColor = UIColor.green
        self.backImageView.backgroundColor = UIColor.brown
        self.frontImageView.backgroundColor = UIColor.magenta
        
      
        
        super.init(frame: frame)
        
        self.addSubview(self.topImageView)
        self.addSubview(self.bottomImageView)
        self.addSubview(self.frontImageView)
        self.addSubview(self.backImageView)
        self.addSubview(self.rightImageView)
        self.addSubview(self.leftImageView)
        
        
        let yesButton:UIButton = UIButton(frame: CGRect(x: Int(self.frame.width/2), y: margin, width: 80, height: 50))
        yesButton.backgroundColor = UIColor.white
        yesButton.setTitle("Yes", for: .normal)
        yesButton.setTitleColor(UIColor.green, for:  .normal)
        yesButton.addTarget(self, action:#selector(self.yesButtonClicked), for: .touchUpInside)
        self.addSubview(yesButton)
        
        
        let noButton:UIButton = UIButton(frame: CGRect(x: (Int)(self.frame.width/2) + margin + 80, y: margin, width: 80, height: 50))
        noButton.backgroundColor = UIColor.white
        noButton.setTitle("No", for: .normal)
        noButton.setTitleColor(UIColor.green, for:  .normal)
        noButton.addTarget(self, action:#selector(self.noButtonClicked), for: .touchUpInside)
        self.addSubview(noButton)

        


    
      
    }
    
    func yesButtonClicked() {
        print("yes Button Clicked")
    }
    
    func noButtonClicked() {
        print("no Button Clicked")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func build2DCube(colorArray: [UIColor]) {
        for (index, element) in colorArray.enumerated() {
            switch index {
            case 0:
                self.frontImageView.backgroundColor = element
            case 1:
                self.rightImageView.backgroundColor = element
            case 2:
                self.backImageView.backgroundColor = element
            case 3:
                self.leftImageView.backgroundColor = element
            case 4:
                self.topImageView.backgroundColor = element
            case 5:
                self.bottomImageView.backgroundColor = element
            default:
                print("error")
            }
        }
     
        
        self.setNeedsDisplay()
        
      
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
  
}
