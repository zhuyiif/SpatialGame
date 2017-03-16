//
//  CubeInstructionController.swift
//  spatial
//
//  Created by yi zhu on 3/15/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit
import SCLAlertView

class CubeInstructionController: SpatialBaseController {
    
    let textLable:UILabel = UILabel()
    let up1ImageView:UIImageView = UIImageView()
    let down1ImageView:UIImageView = UIImageView()
    
    let up2ImageView:UIImageView = UIImageView()
    let down2ImageView:UIImageView = UIImageView()
    
    
    let textLable1:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
  
        SCLAlertView().showTitle(
            "tips".localized(withComment: ""), // Title of view
            subTitle: "fold_tips".localized(withComment: ""), // String of view
            duration: 8.0, // Duration to show before closing automatically, default: 0.0
            completeText: "done".localized(withComment: ""), // Optional button value, default: ""
            style: .success, // Styles - see below.
            colorStyle: 0xA429FF,
            colorTextButton: 0xFFFFFF
            )
        
        self.backButton.addTarget(self, action:#selector(self.backMButtonClicked), for: .touchUpInside)
    }
    
    override func setupViews() {
        super.setupViews()
        self.view.addSubview(textLable)
        
        textLable.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.view).offset(50)
            make.left.equalTo(self.view).offset(30)
        }
        
        textLable.text="fold_up".localized(withComment: "")
        textLable.textColor = UIColor.flatOrange
        
        self.view.addSubview(up1ImageView)
        up1ImageView.image = UIImage(named: "art.scnassets/IMG_3286.JPG")!
        up1ImageView.contentMode = UIViewContentMode.scaleAspectFit
        up1ImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.height/5.0)
            make.top.equalTo(self.textLable).offset(30)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        self.view.addSubview(up2ImageView)
        up2ImageView.image = UIImage(named: "art.scnassets/IMG_3287.JPG")!
        up2ImageView.contentMode = UIViewContentMode.scaleAspectFit
        up2ImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.height/5.0)
            make.top.equalTo(self.up1ImageView).offset(self.view.height/5.0)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        
        self.view.addSubview(textLable1)
        
        textLable1.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.top.equalTo(self.up2ImageView).offset(self.view.height/5.0)
            make.left.equalTo(self.view).offset(20)
        }
        
        textLable1.text="fold_down".localized(withComment: "")
        textLable1.textColor = UIColor.flatOrange
        
        self.view.addSubview(down1ImageView)
        down1ImageView.image = UIImage(named: "art.scnassets/IMG_3289.JPG")!
        down1ImageView.contentMode = UIViewContentMode.scaleAspectFit
        down1ImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.height/5.0)
            make.top.equalTo(self.textLable1).offset(20)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        
        self.view.addSubview(down2ImageView)
        down2ImageView.image = UIImage(named: "art.scnassets/IMG_3290.JPG")!
        down2ImageView.contentMode = UIViewContentMode.scaleAspectFit
        down2ImageView.snp.makeConstraints { (make) in
            make.height.equalTo(self.view.height/5.0)
            make.top.equalTo(self.down1ImageView).offset(self.view.height/5.0)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }

        
        
        
        
        
    }
    
    
    func backMButtonClicked() {
        self.dismiss(animated: true) { 
            
        }
    
    }
  
}
