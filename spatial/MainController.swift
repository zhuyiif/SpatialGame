//
//  MainController.swift
//  spatial
//
//  Created by yi zhu on 2/26/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit


class MainController: UIViewController {
    
    var snakeCubeButton:UIButton = RaisedButton()
    var singleCubeButton:UIButton = RaisedButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.flatYellow
        
        let snameImage:UIImage = UIImage(named: "art.scnassets/snake.jpg")!
        
        let cubeImage:UIImage = UIImage(named: "art.scnassets/cube1.jpg")!
        
        
        snakeCubeButton = RaisedButton()
        snakeCubeButton.backgroundColor = UIColor.white
        snakeCubeButton.setTitle("snake_menu".localized(withComment: ""), for: .normal)
        snakeCubeButton.setImage(snameImage, for: .normal)
        snakeCubeButton.setTitleColor(UIColor.flatGreen, for:  .normal)
        
      //  self.view.addSubview(snakeCubeButton)
        
     
        
        snakeCubeButton.imageView?.contentMode = .scaleAspectFit
        
        snakeCubeButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        snakeCubeButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        snakeCubeButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        snakeCubeButton.addTarget(self, action:#selector(self.snakeButtonClicked), for: .touchUpInside)
        
        
        singleCubeButton = RaisedButton()
        singleCubeButton.backgroundColor = UIColor.white
        singleCubeButton.setImage(cubeImage, for: .normal)
        singleCubeButton.setTitle("cube_menu".localized(withComment: ""), for: .normal)
        singleCubeButton.setTitleColor(UIColor.flatGreen, for:  .normal)
        
        singleCubeButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        singleCubeButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        singleCubeButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        self.view.addSubview(singleCubeButton)
        
        singleCubeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(50)
            make.top.equalTo(self.view).offset(200)
            make.right.equalTo(self.view).offset(-50)
            
            
            make.height.equalTo(50)
            
        }
        
        
        
//        snakeCubeButton.snp.makeConstraints { (make) in
//            make.height.equalTo(50)
//            make.top.equalTo(self.singleCubeButton).offset(100)
//            make.left.equalTo(self.singleCubeButton)
//            make.right.equalTo(self.singleCubeButton)
//            
//           
//            
//        }
        
        singleCubeButton.imageView?.contentMode = .scaleAspectFit
        
        singleCubeButton.addTarget(self, action:#selector(self.singleButtonClicked), for: .touchUpInside)
        
        

    }
    
    func singleButtonClicked() {
       
        print("singleButtonClicked Button Clicked")
        let gameViewCtrl = GameViewController()
        
        self.navigationController!.pushViewController(gameViewCtrl, animated: true)

    }
    
    func snakeButtonClicked() {
        
        print("snake Button Clicked")
        let gameViewCtrl = SnakeCubeController()
        
        self.navigationController!.pushViewController(gameViewCtrl, animated: true)
        
    }
}
