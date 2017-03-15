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
    
    let boxSize:CGFloat = 1
    
    let stepM = Float(1) * (-1)
    let stepP = Float(1)
    
    var boxNodeF1Array:[SCNNode] = []
    
   
    
    
    var cameraNode = SCNNode()
    
    var rotateSView: SCNView = SCNView()
    
    var rotateCameraNode = SCNNode()
    
    //    var colorArray: [UIColor] = [UIColor.flatRed, UIColor.flatYellow, UIColor.flatBlue, UIColor.flatGreen, UIColor.flatGray, UIColor.flatPurple]
    
    var boxBg = UIImage(named: "art.scnassets/boxbg.png")
    
    var colorArray: [UIImage] = Array()
    
    var colorArrayIndex: Int = 0
    
    var questionButtonsView: QuestionAndButtonsView = QuestionAndButtonsView()
    
    var origialRotate = (x:Int,y:Int,z:Int)(0,0,0)
    
    var blackListTuple:[(Int,Int,Int)] = []
    var blackListTuple1:[(Int,Int,Int)] = []
    
    var currentAnswer: Bool = false
    
    
    func setupBlackList(){
        blackListTuple.append((13,3,9))
        blackListTuple.append((9,13,5))
        blackListTuple.append((9,11,1))
        blackListTuple.append((9,1,5))
        blackListTuple.append((7,3,9))
        blackListTuple.append((3,13,7))
        blackListTuple.append((9,13,11))
        blackListTuple.append((9,5,13))
        blackListTuple.append((9,5,1))
        blackListTuple.append((1,9,13))
        blackListTuple.append((13,9,3))
        blackListTuple.append((3,7,13))
        blackListTuple.append((5,9,1))
    }
    
    func setupBlackList1(){
        blackListTuple1.append((9,5,7))
        blackListTuple1.append((13,9,5))
        blackListTuple1.append((9,3,13))
        blackListTuple1.append((1,9,5))
        blackListTuple1.append((9,5,1))
        blackListTuple1.append((9,5,13))
        blackListTuple1.append((7,3,11))
        blackListTuple1.append((3,9,13))
        blackListTuple1.append((13,9,3))
        blackListTuple1.append((11,3,7))
        blackListTuple1.append((3,13,7))
        blackListTuple1.append((7,3,13))
        blackListTuple1.append((9,13,1))
        blackListTuple1.append((3,7,11))
        blackListTuple1.append((5,9,13))
         blackListTuple1.append((7,3,11))
        blackListTuple1.append((5,9,1))
        blackListTuple1.append((3,13,9))
        blackListTuple1.append((1,11,5))
        blackListTuple1.append((9,1,13))
        blackListTuple1.append((1,11,5))
        blackListTuple1.append((3,11,7))
        blackListTuple1.append((13,3,7))
        blackListTuple1.append((9,13,5))
        blackListTuple1.append((9,1,5))
        blackListTuple1.append((1,9,13))
        blackListTuple1.append((3,7,13))
        blackListTuple1.append((13,3,9))
        blackListTuple1.append((13,9,1))
        blackListTuple1.append((9,13,3))
        blackListTuple1.append((1,13,9))
        blackListTuple1.append((7,1,13))
        blackListTuple1.append((9,13,1))
   
    }
    
    func isBlackTuble(rotate3:(Int,Int,Int)) -> Bool {
        let result =  blackListTuple.contains{ $0 == rotate3 }
        
        return result
        
    }
    
    func isBlackTuble1(rotate3:(Int,Int,Int)) -> Bool {
        let result =  blackListTuple1.contains{ $0 == rotate3 }
        
        return result
        
    }
    
    func isduplicateItemsTuble(rotate3:(Int,Int,Int)) -> Bool {
        
        if(rotate3.0 == rotate3.1 || rotate3.1 == rotate3.2 || rotate3.0 == rotate3.2) {
            return true
        }
        else   if(abs(rotate3.0 - rotate3.1) <= 2  || abs(rotate3.1 - rotate3.2) <= 2 || abs(rotate3.0 - rotate3.2) <= 2) {
            return true
        }else {
            return false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlackList()
        setupBlackList1()
        
        self.colorArray = [boxBg!, boxBg!, boxBg!, boxBg!, boxBg!, boxBg!]
        setupOriginalView()
        setupQuestionView()
        nextQuestion(scene: rotateSView.scene!)
        setupQuestionButtonsView()
        
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
    
    
    func generateFalseCube() {
        
        boxNodeF1Array.removeAll()
        
        let dNode1 = duplicateNode(node: boxNode1)
        
        dNode1.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
        boxNodeF1Array.append(dNode1)
        
        let dNode2 = duplicateNode(node: boxNode2)
        boxNodeF1Array.append(dNode2)
        dNode1.addChildNode(dNode2)
        
        let dNode3 = duplicateNode(node: boxNode3)
        boxNodeF1Array.append(dNode3)
        dNode1.addChildNode(dNode3)
        
        let dNode4 = duplicateNode(node: boxNode4)
        boxNodeF1Array.append(dNode4)
        dNode1.addChildNode(dNode4)
        
        let dNode5 = duplicateNode(node: boxNode5)
        boxNodeF1Array.append(dNode5)
        dNode1.addChildNode(dNode5)
        
        let dNode6 = duplicateNode(node: boxNode6)
        boxNodeF1Array.append(dNode6)
        dNode1.addChildNode(dNode6)
        
        let dNode7 = duplicateNode(node: boxNode7)
        let position7 = SCNVector3(x: stepM*(-1), y: stepM * 3, z: stepP)
        dNode7.position = position7
        boxNodeF1Array.append(dNode7)
        dNode1.addChildNode(dNode7)
        
        let dNode8 = duplicateNode(node: boxNode8)
        let position8 = SCNVector3(x: stepM*(-2), y: stepM * 3, z: stepP)
        dNode8.position = position8
        boxNodeF1Array.append(dNode8)
        dNode1.addChildNode(dNode8)
    }
    
    
    func generateFalseCube1() {
        
        boxNodeF1Array.removeAll()
        
        let dNode1 = duplicateNode(node: boxNode1)
        boxNodeF1Array.append(dNode1)
        
        dNode1.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
        
        let dNode2 = duplicateNode(node: boxNode2)
        dNode2.position.x = dNode2.position.x + stepM*(-1)
        dNode2.position.z = dNode2.position.z + stepM*(-1)
        boxNodeF1Array.append(dNode2)
        dNode1.addChildNode(dNode2)
        
        let dNode3 = duplicateNode(node: boxNode3)
        boxNodeF1Array.append(dNode3)
        dNode1.addChildNode(dNode3)
        
        let dNode4 = duplicateNode(node: boxNode4)
        boxNodeF1Array.append(dNode4)
        dNode1.addChildNode(dNode4)
        
        let dNode5 = duplicateNode(node: boxNode5)
        boxNodeF1Array.append(dNode5)
        dNode1.addChildNode(dNode5)
        
        let dNode6 = duplicateNode(node: boxNode6)
        boxNodeF1Array.append(dNode6)
        dNode1.addChildNode(dNode6)
        
        let dNode7 = duplicateNode(node: boxNode7)
        boxNodeF1Array.append(dNode7)
        dNode1.addChildNode(dNode7)
        
        let dNode8 = duplicateNode(node: boxNode8)
        boxNodeF1Array.append(dNode8)
        dNode1.addChildNode(dNode8)
    }

    
    func generateRightCube(){
        
        boxNodeT1 = duplicateNode(node: boxNode1)
        
        boxNodeT2 = duplicateNode(node: boxNode2)
        boxNodeT1.addChildNode(boxNodeT2)
        
        boxNodeT3 = duplicateNode(node: boxNode3)
        boxNodeT1.addChildNode(boxNodeT3)
        
        boxNodeT4 = duplicateNode(node: boxNode4)
        boxNodeT1.addChildNode(boxNodeT4)
        
        boxNodeT5 = duplicateNode(node: boxNode5)
        boxNodeT1.addChildNode(boxNodeT5)
        
        boxNodeT6 = duplicateNode(node: boxNode6)
        boxNodeT1.addChildNode(boxNodeT6)
        
        boxNodeT7 = duplicateNode(node: boxNode7)
        boxNodeT1.addChildNode(boxNodeT7)
        
        boxNodeT8 = duplicateNode(node: boxNode8)
        boxNodeT1.addChildNode(boxNodeT8)

        
    }

    
    func duplicateNode(node:SCNNode) -> SCNNode {
        let dNode = node.clone();
        dNode.geometry = node.geometry?.copy() as! SCNGeometry?;
        dNode.geometry?.firstMaterial = node.geometry?.firstMaterial?.copy() as! SCNMaterial?;
        
        return dNode;
        
    }
    
    func resetOrginNode(){
        boxNode1.transform = SCNMatrix4Identity
    }
    
    func setupOriginalView() {
        
        resetOrginNode()
        
        let scene = SCNScene()
        
     
        
        // create and add a camera to the scene
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        let boxGeometry = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode1.geometry = boxGeometry
        scene.rootNode.addChildNode(boxNode1)
        boxNode1.geometry?.materials = buildMaterialArray()
      
        
        
        let position2 = SCNVector3(x: 0, y: 0, z: stepM)
        let boxGeometry2 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode2.geometry = boxGeometry2
        boxNode2.geometry?.materials = buildMaterialArray()
        boxNode2.position = position2
        boxNode1.addChildNode(boxNode2)
       
        
      
        
        let position3 = SCNVector3(x: 0, y: stepM, z: 0)
        let boxGeometry3 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode3.geometry = boxGeometry3
        boxNode3.geometry?.materials = buildMaterialArray()
        boxNode3.position = position3
        boxNode1.addChildNode(boxNode3)
        
        boxNodeT3 = duplicateNode(node: boxNode3)
        boxNodeT1.addChildNode(boxNodeT3)
        
        let position4 = SCNVector3(x: 0, y: stepM * 2, z: 0)
        let boxGeometry4 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode4.geometry = boxGeometry4
        boxNode4.geometry?.materials = buildMaterialArray()
        boxNode4.position = position4
        boxNode1.addChildNode(boxNode4)
        
       
        
        let position5 = SCNVector3(x: 0, y: stepM * 3, z: 0)
        let boxGeometry5 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode5.geometry = boxGeometry5
        boxNode5.geometry?.materials = buildMaterialArray()
        boxNode5.position = position5
        boxNode1.addChildNode(boxNode5)
        
       
        
        
        addArrayColorIndex()
        let position6 = SCNVector3(x: 0, y: stepM * 3, z: stepP)
        let boxGeometry6 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode6.geometry = boxGeometry6
        boxNode6.geometry?.materials = buildMaterialArray()
        boxNode6.position = position6
        boxNode1.addChildNode(boxNode6)
        
       
        
        let position7 = SCNVector3(x: stepM, y: stepM * 3, z: stepP)
        let boxGeometry7 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode7.geometry = boxGeometry7
        boxNode7.geometry?.materials = buildMaterialArray()
        boxNode7.position = position7
        boxNode1.addChildNode(boxNode7)
        
        
        
        let position8 = SCNVector3(x: stepM * 2, y: stepM * 3, z: stepP)
        let boxGeometry8 = SCNBox(width: boxSize, height: boxSize, length: boxSize, chamferRadius: 0)
        boxNode8.geometry = boxGeometry8
        boxNode8.geometry?.materials = buildMaterialArray()
        boxNode8.position = position8
        boxNode1.addChildNode(boxNode8)
        
      
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 9)
        
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
    
    func generate3RoateNumber()->(x: Int, y: Int, z: Int) {
        
        
        
        var rotate3:[Int] = uniqueOddRandoms(numberOfRandoms: 3, minNum: 1, maxNum: 11)
        
        
        
        var tuple3 = (rotate3[0],rotate3[1],rotate3[2])
        
        while(isBlackTuble(rotate3: tuple3) || isduplicateItemsTuble(rotate3: tuple3)){
            
            rotate3 = uniqueOddRandoms(numberOfRandoms: 3, minNum: 1, maxNum: 11)
            tuple3 = (rotate3[0],rotate3[1],rotate3[2])
        }
        
        
        return tuple3
        
    }
    
    func generate3RoateNumber1()->(x: Int, y: Int, z: Int) {
        
        
        
        var rotate3:[Int] = uniqueOddRandoms(numberOfRandoms: 3, minNum: 1, maxNum: 11)
        
        
        
        var tuple3 = (rotate3[0],rotate3[1],rotate3[2])
        
        while(isBlackTuble1(rotate3: tuple3) || isduplicateItemsTuble(rotate3: tuple3)){
            
            rotate3 = uniqueOddRandoms(numberOfRandoms: 3, minNum: 1, maxNum: 11)
            tuple3 = (rotate3[0],rotate3[1],rotate3[2])
        }
        
   
        return tuple3
        
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
        rotateCameraNode.position = SCNVector3(x: 0, y: 0, z: 9)
        

      
        // retrieve the SCNView
        let scnView = rotateSView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // configure the view
        scnView.backgroundColor = UIColor.flatLime
        
        scnView.autoenablesDefaultLighting = false
        
        
    }
    
    func nextQuestion(scene:SCNScene){
        
        //prepare orginal
        
        var rotate3 = generate3RoateNumber()
        
        
        self.origialRotate = rotate3
        
        
        print("\(rotate3.x)" + ":" + "\(rotate3.y)" + ":" + "\(rotate3.z)")
        
        
        var roYAngle = (Float)(M_PI * Double(rotate3.y)/6)
        var roYMat = SCNMatrix4MakeRotation(roYAngle, 0, 1, 0)
        
        var roXAngle = (Float)(M_PI * Double(rotate3.x)/6)
        var roXMat = SCNMatrix4MakeRotation(roXAngle, 1, 0, 0)
        
        var roZAngle = (Float)(M_PI * Double(rotate3.z)/6)
        var roZMat = SCNMatrix4MakeRotation(roZAngle, 0, 0, 1)
        
        var finalMat :SCNMatrix4 = SCNMatrix4Identity
        
        finalMat  = SCNMatrix4Mult(roZMat, roXMat)
        
        finalMat  = SCNMatrix4Mult(finalMat, roYMat)
        
        boxNode1.transform = finalMat

        
        // pepare question
        
        
        
        scene.rootNode.enumerateChildNodes { (node, stop) -> Void in
            node.removeFromParentNode()
        }
        
        generateRightCube()
        
        rotateCameraNode = SCNNode()
        rotateCameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(rotateCameraNode)
        
        // place the camera
        rotateCameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        
        generateFalseCube1()
        let random = Int(arc4random_uniform(3))
        
        var rootCode = boxNodeT1
        
        if random == 2 {
            scene.rootNode.addChildNode(boxNodeF1Array[0])
            rootCode = boxNodeF1Array[0]
            self.currentAnswer = false
            print("false")
            
            rotate3 = generate3RoateNumber1()
            
            while(rotate3 == self.origialRotate){
                rotate3 = generate3RoateNumber1()
            }

        }
        else {
            scene.rootNode.addChildNode(boxNodeT1)
            rootCode = boxNodeT1
            print("true")
            self.currentAnswer = true
            
            rotate3 = generate3RoateNumber()
            
            while(rotate3 == self.origialRotate){
                rotate3 = generate3RoateNumber()
            }

        }
        
        
        print("q:"+"\(rotate3.x)" + ":" + "\(rotate3.y)" + ":" + "\(rotate3.z)")
        
        roYAngle = (Float)(M_PI * Double(rotate3.y)/6)
        roYMat = SCNMatrix4MakeRotation(roYAngle, 0, 1, 0)
        
        roXAngle = (Float)(M_PI * Double(rotate3.x)/6)
        roXMat = SCNMatrix4MakeRotation(roXAngle, 1, 0, 0)
        
        roZAngle = (Float)(M_PI * Double(rotate3.z)/6)
        roZMat = SCNMatrix4MakeRotation(roZAngle, 0, 0, 1)
        
        finalMat  = SCNMatrix4Identity
        
        finalMat  = SCNMatrix4Mult(roZMat, roXMat)
        
        finalMat  = SCNMatrix4Mult(finalMat, roYMat)
        
        rootCode.transform = finalMat
        
        // prepare orginal
        
        
        
        
    }
    
    func setupQuestionButtonsView() {
        
        
        self.view.addSubview(questionButtonsView)
        
        questionButtonsView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view.frame.height*6/10.0 + 54)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
            
            
        }
        
        questionButtonsView.questionsLabel.text = "questions1".localized(withComment: "")
        
        questionButtonsView.backgroundColor = UIColor.flatOrange
        questionButtonsView.yesButton.addTarget(self, action:#selector(self.yesButtonClicked), for: .touchUpInside)
        questionButtonsView.noButton.addTarget(self, action:#selector(self.noButtonClicked), for: .touchUpInside)
        questionButtonsView.tipsButton.addTarget(self, action:#selector(self.tipsButtonClicked), for: .touchUpInside)
        
    }
    
    func yesButtonClicked() {
        
    
        showAlert(isRight: self.currentAnswer){
            
            self.nextQuestion(scene: self.rotateSView.scene!)
            
        }
        
        
    }
    
    func noButtonClicked() {
        showAlert(isRight: !self.currentAnswer){
            
            self.nextQuestion(scene: self.rotateSView.scene!)
            
        }
        
    }
    
    func tipsButtonClicked() {
        
        let boxRatation = SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 0.5);
        
        let boxRatation1 = SCNAction.rotateBy(x: -1, y: -1, z: -1, duration: 0.5);
        
        boxNode1.runAction(boxRatation) {
            self.boxNode1.runAction(boxRatation1)
        }
        
        
        boxNodeT1.runAction(boxRatation) {
            self.boxNodeT1.runAction(boxRatation1)
        }
        
        
        boxNodeF1Array[0].runAction(boxRatation) {
            self.boxNodeF1Array[0].runAction(boxRatation1)
        }
        
    }
    

    
    
}
