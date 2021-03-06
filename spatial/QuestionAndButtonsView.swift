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
import SnapKit

class QuestionAndButtonsView: UIView {
    
    var yesButton:UIButton = RaisedButton()
    var noButton:UIButton = RaisedButton()
    var tipsButton:UIButton = RaisedButton()
    
    var backButton:UIButton = RaisedButton()
    
    var questionsLabel: UILabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonTop = 60
        
        
        questionsLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat(buttonTop))
      //  questionsLabel.text = "questions".localized(withComment: "")
        questionsLabel.lineBreakMode = .byWordWrapping // or NSLineBreakMode.ByWordWrapping
        questionsLabel.numberOfLines = 0
        questionsLabel.textAlignment = NSTextAlignment.center
        
        
        // questionsLabel.backgroundColor = UIColor.gray
        questionsLabel.textColor = UIColor.darkText
        
        let screenWidth = frame.width
        
        let buttonW = (Int) (screenWidth/4)
        let marginXButton = Int((Int(screenWidth) - buttonW * 3)/4)
        
        let buttonH = (Int) (Double(buttonW) * 0.4)
        
        
        
        yesButton.frame = CGRect(x: marginXButton, y: buttonTop , width: buttonW, height: buttonH)
        yesButton.backgroundColor = UIColor.flatWhite
        yesButton.setTitle("yes".localized(withComment: ""), for: .normal)
        yesButton.setTitleColor(UIColor.flatGreen, for:  .normal)
        yesButton.make3D()
        
        
        
        
        noButton.frame = CGRect(x: marginXButton * 2 + buttonW, y: buttonTop , width: buttonW, height: buttonH)
        noButton.backgroundColor = UIColor.flatWhite
        noButton.setTitle("no".localized(withComment: ""), for: .normal)
        noButton.setTitleColor(UIColor.red, for:  .normal)
        noButton.make3D()
        self.addSubview(noButton)
        
        
        tipsButton.frame = CGRect(x: marginXButton * 3 + 2 * buttonW, y: buttonTop , width: buttonW, height: buttonH)
        tipsButton.backgroundColor = UIColor.flatWhite
        tipsButton.setTitle("tips".localized(withComment: ""), for: .normal)
        tipsButton.setTitleColor(UIColor.flatPurple, for:  .normal)
        tipsButton.make3D()
        self.addSubview(tipsButton)
        
        
        
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(questionsLabel)
        self.addSubview(yesButton)
        self.addSubview(noButton)
        self.addSubview(tipsButton)
        
    }
    
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    
}
