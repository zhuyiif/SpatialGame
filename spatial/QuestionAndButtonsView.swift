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
   
    
 
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let buttonTop = 60
        
        let questionsLabel: UILabel = UILabel()
        questionsLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat(buttonTop))
        questionsLabel.text = "questions".localized(withComment: "")
        questionsLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        questionsLabel.numberOfLines = 0
        questionsLabel.textAlignment = NSTextAlignment.center
        
        self.addSubview(questionsLabel)
       // questionsLabel.backgroundColor = UIColor.gray
        questionsLabel.textColor = UIColor.darkText
        
        
        
        let screenWidth = frame.width
        
        let buttonW = (Int) (screenWidth/4)
        
        let viewWidth = screenWidth * (1 - (CGFloat)(Constants.DICE_VIEW_MARGIN_RATIO * 2))
        
        let marginXButton = Int((Int(screenWidth) - buttonW * 3)/4)
        
      
      
        
        let buttonH = (Int) (Double(buttonW) * 0.4)
        
       
        
        yesButton = RaisedButton(frame: CGRect(x: marginXButton, y: buttonTop , width: buttonW, height: buttonH))
        yesButton.backgroundColor = UIColor.flatWhite
        yesButton.setTitle("yes".localized(withComment: ""), for: .normal)
        yesButton.setTitleColor(UIColor.flatGreen, for:  .normal)
        yesButton.make3D()

        self.addSubview(yesButton)
        
        
        noButton = RaisedButton(frame: CGRect(x: marginXButton * 2 + buttonW, y: buttonTop , width: buttonW, height: buttonH))
        noButton.backgroundColor = UIColor.flatWhite
        noButton.setTitle("no".localized(withComment: ""), for: .normal)
        noButton.setTitleColor(UIColor.red, for:  .normal)
        noButton.make3D()
        self.addSubview(noButton)
        
        
        tipsButton = RaisedButton(frame: CGRect(x: marginXButton * 3 + 2 * buttonW, y: buttonTop , width: buttonW, height: buttonH))
        tipsButton.backgroundColor = UIColor.flatWhite
        tipsButton.setTitle("tips".localized(withComment: ""), for: .normal)
        tipsButton.setTitleColor(UIColor.flatPurple, for:  .normal)
        tipsButton.make3D()
        self.addSubview(tipsButton)
        
        
        
        
    }
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
}
