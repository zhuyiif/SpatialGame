//
//  SnakeCubeController.swift
//  spatial
//
//  Created by yi zhu on 3/1/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit
import Material
import SnapKit
import SceneKit


class SnakeCubeController: SpatialBaseController {
    
    var originalSView: SCNView = SCNView()
    
    var boxNode1: SCNNode = SCNNode()
    var boxNode2: SCNNode = SCNNode()
    var boxNode3: SCNNode = SCNNode()
    var boxNode4: SCNNode = SCNNode()
    var boxNode5: SCNNode = SCNNode()
    var boxNode6: SCNNode = SCNNode()
    var boxNode7: SCNNode = SCNNode()
    var boxNode8: SCNNode = SCNNode()
    
    var cameraNode = SCNNode()
    
    var rotateSView1: SCNView = SCNView()
    var rotateSView2: SCNView = SCNView()
    var rotateSView3: SCNView = SCNView()
    
    var colorArray: [UIColor] = [UIColor.flatRed, UIColor.flatYellow, UIColor.flatBlue, UIColor.flatGreen, UIColor.flatGray, UIColor.flatPurple]
    
    var colorArrayIndex: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOriginalView()
        
    }
    
    func buildMaterialArray() -> Array<SCNMaterial> {
        
        
        
        var materialArray:[SCNMaterial] = []
        
        var tempIndex = colorArrayIndex
        
     
        for _ in 0...5 {
            
            if tempIndex > 5 {
                tempIndex = 0
            }
            
            let materialItem = SCNMaterial()
            materialItem.diffuse.contents = colorArray[tempIndex]
            materialItem.isDoubleSided = true
            materialArray.append(materialItem)
            
            tempIndex += 1
            
        }
        
        
        colorArrayIndex += 1
        
        if colorArrayIndex > 5 {
            colorArrayIndex = 0
        }
       
        
//        let materialItem1 = SCNMaterial()
//        materialItem1.diffuse.contents = UIColor.flatRed
//        materialItem1.isDoubleSided = true
//        
//        let materialItem2 = SCNMaterial()
//        materialItem2.diffuse.contents = UIColor.flatYellow
//        materialItem2.isDoubleSided = true
//        
//        let materialItem3 = SCNMaterial()
//        materialItem3.diffuse.contents = UIColor.flatBlue
//        materialItem3.isDoubleSided = true
//        
//        let materialItem4 = SCNMaterial()
//        materialItem4.diffuse.contents = UIColor.flatGreen
//        materialItem4.isDoubleSided = true
//        
//        let materialItem5 = SCNMaterial()
//        materialItem5.diffuse.contents = UIColor.flatGray
//        materialItem5.isDoubleSided = true
//        
//        let materialItem6 = SCNMaterial()
//        materialItem6.diffuse.contents = UIColor.flatPurple
//        materialItem6.isDoubleSided = true
//        
//        materialArray.append(materialItem1)
//        materialArray.append(materialItem2)
//        materialArray.append(materialItem3)
//        materialArray.append(materialItem4)
//        materialArray.append(materialItem5)
//        materialArray.append(materialItem6)
        
        return materialArray
        
    }
    
    func setupOriginalView() {
   
    
        let scene = SCNScene()
        
        let boxSize:CGFloat = 1
        
        let stepM = Float(boxSize) * (-1)
        let stepP = Float(boxSize)
        
        // create and add a camera to the scene
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        let boxGeometry = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode1 = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode1)
        boxNode1.geometry?.materials = buildMaterialArray()
        

        let position2 = SCNVector3(x: 0, y: 0, z: stepM)
        let boxGeometry2 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode2 = SCNNode(geometry: boxGeometry2)
        boxNode2.geometry?.materials = buildMaterialArray()
        boxNode2.position = position2
        scene.rootNode.addChildNode(boxNode2)
        
        let position3 = SCNVector3(x: 0, y: stepM, z: 0)
        let boxGeometry3 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode3 = SCNNode(geometry: boxGeometry3)
        boxNode3.geometry?.materials = buildMaterialArray()
        boxNode3.position = position3
        scene.rootNode.addChildNode(boxNode3)
        
        let position4 = SCNVector3(x: 0, y: stepM * 2, z: 0)
        let boxGeometry4 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode4 = SCNNode(geometry: boxGeometry4)
        boxNode4.geometry?.materials = buildMaterialArray()
        boxNode4.position = position4
        scene.rootNode.addChildNode(boxNode4)
        
        let position5 = SCNVector3(x: 0, y: stepM * 3, z: 0)
        let boxGeometry5 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode5 = SCNNode(geometry: boxGeometry5)
        boxNode5.geometry?.materials = buildMaterialArray()
        boxNode5.position = position5
        scene.rootNode.addChildNode(boxNode5)
        
        let position6 = SCNVector3(x: 0, y: stepM * 3, z: stepP)
        let boxGeometry6 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode6 = SCNNode(geometry: boxGeometry6)
        boxNode6.geometry?.materials = buildMaterialArray()
        boxNode6.position = position6
        scene.rootNode.addChildNode(boxNode6)
        
        let position7 = SCNVector3(x: stepM, y: stepM * 3, z: stepP)
        let boxGeometry7 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode7 = SCNNode(geometry: boxGeometry7)
        boxNode7.geometry?.materials = buildMaterialArray()
        boxNode7.position = position7
        scene.rootNode.addChildNode(boxNode7)
        
        let position8 = SCNVector3(x: stepM * 2, y: stepM * 3, z: stepP)
        let boxGeometry8 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode8 = SCNNode(geometry: boxGeometry8)
        boxNode8.geometry?.materials = buildMaterialArray()
        boxNode8.position = position8
        scene.rootNode.addChildNode(boxNode8)
       
        
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        self.view.addSubview(originalSView)
        originalSView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(self.view.frame.height*4/10.0)
            
        }
        
        // retrieve the SCNView
        let scnView = originalSView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        
        // configure the view
        scnView.backgroundColor = UIColor.flatBlack
        
        scnView.autoenablesDefaultLighting = false
        
        
        
    }
    
    
 
}
