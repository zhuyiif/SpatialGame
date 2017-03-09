//
//  SpatialBaseController.swift
//  spatial
//
//  Created by yi zhu on 3/2/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit
import SCLAlertView


class SpatialBaseController: UIViewController {
    
    var backButton:UIButton = RaisedButton()
    
    func setupViews() {
      
        
        self.view.addSubview(backButton)
        backButton.backgroundColor = UIColor.flatWhite
        backButton.setTitle("back".localized(withComment: ""), for: .normal)
        backButton.setTitleColor(UIColor.flatGreen, for:  .normal)
        backButton.make3D()
        backButton.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.view).offset(Constants.MARGIN)
            make.top.equalTo(self.view).offset(Constants.MARGIN)
            make.height.equalTo(Constants.BACK_BUTTON_H)
            make.width.equalTo(Constants.BACK_BUTTON_W)
            
        }
        
        self.backButton.addTarget(self, action:#selector(self.backButtonClicked), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.statusBarController?.isStatusBarHidden = true
        self.view.backgroundColor = UIColor.flatBlack
        self.setupViews()
        
      
        
    }
    
    func showAlert(isRight:Bool ,closure: @escaping () -> Void) {
        
        if (isRight) {
            
            
            SCLAlertView().showTitle(
                "congrat".localized(withComment: ""), // Title of view
                subTitle: "congrat_detail".localized(withComment: ""), // String of view
                duration: 2.0, // Duration to show before closing automatically, default: 0.0
                completeText: "done".localized(withComment: ""), // Optional button value, default: ""
                style: .success, // Styles - see below.
                colorStyle: 0xA429FF,
                colorTextButton: 0xFFFFFF
                ).setDismissBlock {
                    closure()
            }
            
            
        }
        else {
            
            SCLAlertView().showTitle(
                "sorry".localized(withComment: ""), // Title of view
                subTitle: "wrong_detail".localized(withComment: ""), // String of view
                duration: 2.0, // Duration to show before closing automatically, default: 0.0
                completeText: "done".localized(withComment: ""), // Optional button value, default: ""
                style: .error, // Styles - see below.
                colorStyle: UInt(UIColor.flatRed.hexValue(), radix: 16),
                colorTextButton: UInt(UIColor.flatRed.hexValue(), radix: 16)
            )
            
            
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }  
    
  
    func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

