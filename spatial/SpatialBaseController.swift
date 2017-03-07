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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }  
    
  
    func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

