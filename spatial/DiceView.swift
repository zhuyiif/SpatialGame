//
//  DiceView.swift
//  spatial
//
//  Created by yi zhu on 2/22/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit


enum DiceViewMode {
    /*
     
     x
     x   x   x   x
     x
     
     */
    case mode1
    
    /*
     
     x
     x   x   x   x
     x
     
     */
    case mode2
    
    /*
     
     x   x
     x   x
     x  x
     
     */
    case mode3
}


class DiceView: UIView {
    
    var topImageView: UIImageView!
    var bottomImageView: UIImageView!
    var frontImageView: UIImageView!
    var backImageView: UIImageView!
    var rightImageView: UIImageView!
    var leftImageView: UIImageView!
    
    var viewMode:DiceViewMode!
    
    var marginx:Int!
    var marginy:Int!
    var diceSize:Int!
    
    func computeMarginAndDiceSize(width: CGFloat) {
        let diceViewWidth = width * (1 - (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO * 2))
        
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            diceSize = (Int) (diceViewWidth/6)
            
        }
        else
        {
            diceSize = (Int) (diceViewWidth/5)
        }
        
        marginy = (Int) (width * (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO))
        
        marginx = marginy + diceSize!
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        viewMode = DiceViewMode.mode1
        
        let screenWidth = frame.width
        
        computeMarginAndDiceSize(width: screenWidth)
        
        buildMode1()
        
        self.leftImageView.backgroundColor = UIColor.red
        self.bottomImageView.backgroundColor = UIColor.yellow
        self.rightImageView.backgroundColor = UIColor.blue
        self.topImageView.backgroundColor = UIColor.green
        self.backImageView.backgroundColor = UIColor.brown
        self.frontImageView.backgroundColor = UIColor.magenta
        
        
        self.addSubview(self.topImageView)
        self.addSubview(self.bottomImageView)
        self.addSubview(self.frontImageView)
        self.addSubview(self.backImageView)
        self.addSubview(self.rightImageView)
        self.addSubview(self.leftImageView)
        
        
    }
    
    
    func buildMode1() {
        self.leftImageView = UIImageView(frame: CGRect(x: marginx, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.bottomImageView = UIImageView(frame: CGRect(x: marginx + diceSize, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.rightImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 2, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.topImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 3, y: marginy + diceSize, width: diceSize, height: diceSize))
        
        self.backImageView = UIImageView(frame: CGRect(x: marginx + diceSize , y: marginy , width: diceSize, height: diceSize))
        self.frontImageView = UIImageView(frame: CGRect(x: marginx + diceSize , y: marginy + diceSize * 2 , width: diceSize, height: diceSize))
    }
    
    func buildMode2() {
        
        self.bottomImageView = UIImageView(frame: CGRect(x: marginx, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.rightImageView =  UIImageView(frame: CGRect(x: marginx + diceSize, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.topImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 2, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.leftImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 3, y: marginy + diceSize, width: diceSize, height: diceSize))
        
        self.backImageView = UIImageView(frame: CGRect(x: marginx  , y: marginy , width: diceSize, height: diceSize))
        
        self.frontImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 2 , y: marginy + diceSize * 2 , width: diceSize, height: diceSize))
        
       
    }
    
    func buildMode3() {
        self.leftImageView = UIImageView(frame: CGRect(x: marginx, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.bottomImageView = UIImageView(frame: CGRect(x: marginx + diceSize, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.rightImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 2, y: marginy + diceSize, width: diceSize, height: diceSize))
        self.topImageView = UIImageView(frame: CGRect(x: marginx + diceSize * 3, y: marginy + diceSize, width: diceSize, height: diceSize))
        
        self.backImageView = UIImageView(frame: CGRect(x: marginx + diceSize , y: marginy , width: diceSize, height: diceSize))
        self.frontImageView = UIImageView(frame: CGRect(x: marginx + diceSize , y: marginy + diceSize * 2 , width: diceSize, height: diceSize))
    }
    
    init(frame: CGRect, mode: DiceViewMode) {
        
        super.init(frame: frame)
        let screenWidth = frame.width
        
        computeMarginAndDiceSize(width: screenWidth)
        
        switch mode {
        case .mode1:
            buildMode1()
        case .mode2:
            buildMode2()
        case .mode3:
            buildMode3()
        }
        
        self.leftImageView.backgroundColor = UIColor.red
        self.bottomImageView.backgroundColor = UIColor.yellow
        self.rightImageView.backgroundColor = UIColor.blue
        self.topImageView.backgroundColor = UIColor.green
        self.backImageView.backgroundColor = UIColor.brown
        self.frontImageView.backgroundColor = UIColor.magenta
        
        self.addSubview(self.topImageView)
        self.addSubview(self.bottomImageView)
        self.addSubview(self.frontImageView)
        self.addSubview(self.backImageView)
        self.addSubview(self.rightImageView)
        self.addSubview(self.leftImageView)
    }
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func build2DCube(colorArray: [UIColor]) {
        for (index, element) in colorArray.enumerated() {
            switch index {
            case DiceDirection.front.rawValue:
                self.frontImageView.backgroundColor = element
            case DiceDirection.right.rawValue:
                self.rightImageView.backgroundColor = element
            case DiceDirection.back.rawValue:
                self.backImageView.backgroundColor = element
            case DiceDirection.left.rawValue:
                self.leftImageView.backgroundColor = element
            case DiceDirection.top.rawValue:
                self.topImageView.backgroundColor = element
            case DiceDirection.bottom.rawValue:
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
