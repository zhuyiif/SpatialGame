//
//  QuestionsAndButtonsView.swift
//  spatial
//
//  Created by yi zhu on 2/23/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation

import UIKit

import Material


class QuestionAndButtonsView: UIView {
    
    var yesButton:UIButton = RaisedButton()
    var noButton:UIButton = RaisedButton()
    var tipsButton:UIButton = RaisedButton()
    var tryNext:UIButton = RaisedButton()
    
 
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let buttonTop = 80
        
        let questionsLabel: UILabel = UILabel()
        questionsLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat(buttonTop))
        questionsLabel.text = "Dose the middle cube can be made based on the unfolded cube?"
        questionsLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        questionsLabel.numberOfLines = 0
        questionsLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(questionsLabel)
       // questionsLabel.backgroundColor = UIColor.gray
        questionsLabel.textColor = UIColor.darkText
        
        
        
        let screenWidth = frame.width
        let viewWidth = screenWidth * (1 - (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO * 2))
        
        let marginXButton = (Int) (screenWidth * (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO))
        let buttonW = (Int) (viewWidth/4)
      
        
        let buttonH = (Int) (Double(buttonW) * 0.5)
        
       
        
        yesButton = RaisedButton(frame: CGRect(x: marginXButton, y: buttonTop , width: buttonW, height: buttonH))
        yesButton.backgroundColor = UIColor.white
        yesButton.setTitle("Yes", for: .normal)
        yesButton.setTitleColor(UIColor.green, for:  .normal)
        yesButton.make3D()

        self.addSubview(yesButton)
        
        
        noButton = UIButton(frame: CGRect(x: marginXButton * 2 + buttonW, y: buttonTop , width: buttonW, height: buttonH))
        noButton.backgroundColor = UIColor.white
        noButton.setTitle("No", for: .normal)
        noButton.setTitleColor(UIColor.red, for:  .normal)
        noButton.make3D()
        self.addSubview(noButton)
        
        
        tipsButton = UIButton(frame: CGRect(x: marginXButton * 3 + 2 * buttonW, y: buttonTop , width: buttonW, height: buttonH))
        tipsButton.backgroundColor = UIColor.white
        tipsButton.setTitle("Tips", for: .normal)
        tipsButton.setTitleColor(UIColor.red, for:  .normal)
        tipsButton.make3D()
        self.addSubview(tipsButton)
        
        
        tryNext = UIButton(frame: CGRect(x: marginXButton, y: marginXButton * 2 + buttonTop , width: buttonW, height: buttonH))
        tryNext.backgroundColor = UIColor.white
        tryNext.setTitle("Next", for: .normal)
        tryNext.setTitleColor(UIColor.red, for:  .normal)
        tryNext.make3D()
        self.addSubview(tryNext)

        
        
    }
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
}
