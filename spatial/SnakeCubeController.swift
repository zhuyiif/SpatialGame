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
    
    var boxNodeT1: SCNNode = SCNNode()
    var boxNodeT2: SCNNode = SCNNode()
    var boxNodeT3: SCNNode = SCNNode()
    var boxNodeT4: SCNNode = SCNNode()
    var boxNodeT5: SCNNode = SCNNode()
    var boxNodeT6: SCNNode = SCNNode()
    var boxNodeT7: SCNNode = SCNNode()
    var boxNodeT8: SCNNode = SCNNode()
    
    var boxNodeF1: SCNNode = SCNNode()
    var boxNodeF2: SCNNode = SCNNode()
    var boxNodeF3: SCNNode = SCNNode()
    var boxNodeF4: SCNNode = SCNNode()
    var boxNodeF5: SCNNode = SCNNode()
    var boxNodeF6: SCNNode = SCNNode()
    var boxNodeF7: SCNNode = SCNNode()
    var boxNodeF8: SCNNode = SCNNode()
    
    
    var cameraNode = SCNNode()
    
    var rotateSView: SCNView = SCNView()
    
    var rotateCameraNode = SCNNode()
    
    var colorArray: [UIColor] = [UIColor.flatRed, UIColor.flatYellow, UIColor.flatBlue, UIColor.flatGreen, UIColor.flatGray, UIColor.flatPurple]
    
    var colorArrayIndex: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupOriginalView()
        setupQuestionView()
        
    }
    
    func addArrayColorIndex(){
        
        colorArrayIndex += 1
        
        if colorArrayIndex > 5 {
            colorArrayIndex = 0
        }
        
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
        
        addArrayColorIndex()
        
        
        return materialArray
        
    }
    
    func rotateAll() {
        
        var nodeArray:[SCNNode] = []
        nodeArray.append(boxNode1)
        nodeArray.append(boxNode2)
        nodeArray.append(boxNode3)
        nodeArray.append(boxNode4)
        nodeArray.append(boxNode5)
        nodeArray.append(boxNode6)
        nodeArray.append(boxNode7)
        nodeArray.append(boxNode8)
        
        
    }
    
    func duplicateNode(node:SCNNode) -> SCNNode {
        let dNode = node.clone();
        dNode.geometry = node.geometry?.copy() as! SCNGeometry?;
        dNode.geometry?.firstMaterial = node.geometry?.firstMaterial?.copy() as! SCNMaterial?;
        
        return dNode;
        
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
        boxNode1.geometry = boxGeometry
        scene.rootNode.addChildNode(boxNode1)
        boxNode1.geometry?.materials = buildMaterialArray()
        
        boxNodeT1 = duplicateNode(node: boxNode1)
        

        let position2 = SCNVector3(x: 0, y: 0, z: stepM)
        let boxGeometry2 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode2.geometry = boxGeometry2
        boxNode2.geometry?.materials = buildMaterialArray()
        boxNode2.position = position2
        boxNode1.addChildNode(boxNode2)
        
        boxNodeT2 = duplicateNode(node: boxNode2)
        
        let position3 = SCNVector3(x: 0, y: stepM, z: 0)
        let boxGeometry3 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode3.geometry = boxGeometry3
        boxNode3.geometry?.materials = buildMaterialArray()
        boxNode3.position = position3
        boxNode1.addChildNode(boxNode3)
        
        boxNodeT3 = duplicateNode(node: boxNode3)
        
        let position4 = SCNVector3(x: 0, y: stepM * 2, z: 0)
        let boxGeometry4 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode4.geometry = boxGeometry4
        boxNode4.geometry?.materials = buildMaterialArray()
        boxNode4.position = position4
        boxNode1.addChildNode(boxNode4)
        
        boxNodeT4 = duplicateNode(node: boxNode4)
        
        let position5 = SCNVector3(x: 0, y: stepM * 3, z: 0)
        let boxGeometry5 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode5.geometry = boxGeometry5
        boxNode5.geometry?.materials = buildMaterialArray()
        boxNode5.position = position5
        boxNode1.addChildNode(boxNode5)
        
        boxNodeT5 = duplicateNode(node: boxNode5)
        
        
        addArrayColorIndex()
        let position6 = SCNVector3(x: 0, y: stepM * 3, z: stepP)
        let boxGeometry6 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode6.geometry = boxGeometry6
        boxNode6.geometry?.materials = buildMaterialArray()
        boxNode6.position = position6
        boxNode1.addChildNode(boxNode6)
        
        boxNodeT6 = duplicateNode(node: boxNode6)
        
        let position7 = SCNVector3(x: stepM, y: stepM * 3, z: stepP)
        let boxGeometry7 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode7.geometry = boxGeometry7
        boxNode7.geometry?.materials = buildMaterialArray()
        boxNode7.position = position7
        boxNode1.addChildNode(boxNode7)
        
        boxNodeT7 = duplicateNode(node: boxNode7)
        
        let position8 = SCNVector3(x: stepM * 2, y: stepM * 3, z: stepP)
        let boxGeometry8 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode8.geometry = boxGeometry8
        boxNode8.geometry?.materials = buildMaterialArray()
        boxNode8.position = position8
        boxNode1.addChildNode(boxNode8)
        
        boxNodeT8 = duplicateNode(node: boxNode8)
        
    
        
        let roYAngle = (Float)(M_PI)/4
        let roYMat = SCNMatrix4MakeRotation(roYAngle, 0, 1, 0)
        
        let roXAngle = (Float) (M_PI/2 - M_PI/6)
        let roXMat = SCNMatrix4MakeRotation(roXAngle, 1, 0, 0)
        
        let roZAngle = (Float)(M_PI/2 + M_PI/3)
        let roZMat = SCNMatrix4MakeRotation(roZAngle, 0, 0, 1)
        
        var finalMat :SCNMatrix4 = SCNMatrix4Identity
        
        finalMat  = SCNMatrix4Mult(roZMat, roXMat)
      
        boxNode1.transform = finalMat
        
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        self.view.addSubview(originalSView)
        originalSView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(54)
            make.right.equalTo(self.view)
            make.height.equalTo(self.view.frame.height*3/10.0)
            
        }
        
        // retrieve the SCNView
        let scnView = originalSView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        
        // configure the view
        scnView.backgroundColor = UIColor.flatLime
        
        scnView.autoenablesDefaultLighting = false
        
        
        
    }
    
    
    func setupQuestionView() {
        
        self.view.addSubview(rotateSView)
        rotateSView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view.frame.height*3/10.0 + 54)
            make.right.equalTo(self.view)
            make.height.equalTo(self.view.frame.height*3/10.0)
            
        }
        
        let scene = SCNScene()
        
        // create and add a camera to the scene
        rotateCameraNode = SCNNode()
        rotateCameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(rotateCameraNode)
        
        // place the camera
        rotateCameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        scene.rootNode.addChildNode(boxNodeT1)
        boxNodeT1.addChildNode(boxNodeT2)
        boxNodeT1.addChildNode(boxNodeT3)
        boxNodeT1.addChildNode(boxNodeT4)
        boxNodeT1.addChildNode(boxNodeT5)
        boxNodeT1.addChildNode(boxNodeT6)
        boxNodeT1.addChildNode(boxNodeT7)
        boxNodeT1.addChildNode(boxNodeT8)
        
        // retrieve the SCNView
        let scnView = rotateSView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // configure the view
        scnView.backgroundColor = UIColor.flatPink
        
        scnView.autoenablesDefaultLighting = false
        
        //rotate
        
        let roYAngle = (Float)(M_PI)/4
        let roYMat = SCNMatrix4MakeRotation(roYAngle, 0, 1, 0)
        
        let roXAngle = (Float) (M_PI/2 - M_PI/6)
        let roXMat = SCNMatrix4MakeRotation(roXAngle, 1, 0, 0)
        
        let roZAngle = (Float)(M_PI/2 + M_PI/3)
        let roZMat = SCNMatrix4MakeRotation(roZAngle, 0, 0, 1)
        
        var finalMat :SCNMatrix4 = SCNMatrix4Identity
        
        finalMat  = SCNMatrix4Mult(roZMat, roXMat)
        
        boxNodeT1.transform = finalMat
        
    }
    
 
}
