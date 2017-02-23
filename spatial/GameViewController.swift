//
//  GameViewController.swift
//  spatial
//
//  Created by yi zhu on 2/22/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

extension Array {
    var shuffle:[Element] {
        var elements = self
        for index in 0..<elements.count {
            let anotherIndex = Int(arc4random_uniform(UInt32(elements.count-index)))+index
            if anotherIndex != index {
                swap(&elements[index], &elements[anotherIndex])
            }
        }
        return elements
    }
}

class GameViewController: UIViewController {
    
    var currentYAngle: Float = 0.0
    
    var currentXAngle: Float = 0.0
    
    var currentAnswer: Bool = false
   
    
    var boxNode: SCNNode = SCNNode()
    
    var box1Node: SCNNode = SCNNode()

    
    var cubeColorArray:[UIColor]  = []
    
    var mainBoxView: SCNView = SCNView()
    
    var questionBoxView: SCNView = SCNView()
    
    var diceView: DiceView = DiceView()
    
    var cameraNode = SCNNode()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildQuestions()
        
        //build questions
//        cubeColorArray.append(UIColor.green)
//        cubeColorArray.append(UIColor.red)
//        cubeColorArray.append(UIColor.blue)
//        cubeColorArray.append(UIColor.yellow)
//        cubeColorArray.append(UIColor.purple)
//        cubeColorArray.append(UIColor.gray)
        
        diceView = DiceView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3))
        self.view.addSubview(diceView)
        diceView.build2DCube(colorArray: cubeColorArray)
        
        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        let boxGeometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.2)
        boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        
       
       
    
       
        //build material array
        
       buildBoxSides()
        
       
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        
       
       
        mainBoxView.frame = CGRect(x: 0, y: self.view.frame.height/3 , width: self.view.frame.width, height: self.view.frame.height/3)
        mainBoxView.backgroundColor = UIColor.white
        
        self.view.addSubview(mainBoxView)
        
        
        // retrieve the SCNView
        let scnView = mainBoxView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        //scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        scnView.autoenablesDefaultLighting = true
        
        
        let buttonsView = UIView(frame: CGRect(x: 0, y: self.view.frame.height/3*2 , width: self.view.frame.width, height: self.view.frame.height/3))
        
        self.view.addSubview(buttonsView)
        
        buttonsView.backgroundColor = UIColor.orange
        
        
        let marginButton = 20;
        let buttonW = 80
        let buttonH = 50
        
        let yesButton:UIButton = UIButton(frame: CGRect(x: marginButton, y: marginButton, width: buttonW, height: buttonH))
        yesButton.backgroundColor = UIColor.white
        yesButton.setTitle("Yes", for: .normal)
        yesButton.setTitleColor(UIColor.green, for:  .normal)
        yesButton.addTarget(self, action:#selector(self.yesButtonClicked), for: .touchUpInside)
        buttonsView.addSubview(yesButton)
        
        
        let noButton:UIButton = UIButton(frame: CGRect(x: marginButton * 2 + buttonW, y: marginButton, width: buttonW, height: buttonH))
        noButton.backgroundColor = UIColor.white
        noButton.setTitle("No", for: .normal)
        noButton.setTitleColor(UIColor.red, for:  .normal)
        noButton.addTarget(self, action:#selector(self.noButtonClicked), for: .touchUpInside)
        buttonsView.addSubview(noButton)
        
        
        let tipsButton:UIButton = UIButton(frame: CGRect(x: marginButton * 3 + 2 * buttonW, y: marginButton, width: buttonW, height: buttonH))
        tipsButton.backgroundColor = UIColor.white
        tipsButton.setTitle("Tips", for: .normal)
        tipsButton.setTitleColor(UIColor.red, for:  .normal)
        tipsButton.addTarget(self, action:#selector(self.tipsButtonClicked), for: .touchUpInside)
        buttonsView.addSubview(tipsButton)
        
        
      
        
        
     
    }
    
    func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: UInt32) -> [Int] {
        var uniqueNumbers = Set<Int>()
        while uniqueNumbers.count < numberOfRandoms {
            uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
        }
        return Array(uniqueNumbers).shuffle
    }
    
    
    func buildQuestions(){
        
        cubeColorArray.removeAll()
        let colorArray = uniqueRandoms(numberOfRandoms: 6, minNum: 0, maxNum: 5)
        
        for item in colorArray {
            switch item {
            case 0:
                cubeColorArray.append(UIColor.green)
            case 1:
                cubeColorArray.append(UIColor.red)
            case 2:
                cubeColorArray.append(UIColor.blue)
            case 3:
                cubeColorArray.append(UIColor.yellow)
            case 4:
                cubeColorArray.append(UIColor.purple)
            case 5:
                cubeColorArray.append(UIColor.gray)
            default:
                print("error")
            }
        }
        
        if(colorArray[0] <= 2) {
            self.currentAnswer = false
        }
        else {
            self.currentAnswer = true
        }

        
        
        
    }
    
    
    func buildBoxSides() {
        var materialArray:[SCNMaterial] = []
        
        
        
        for color in cubeColorArray {
            let materialItem = SCNMaterial()
            materialItem.diffuse.contents  =  color
            materialItem.locksAmbientWithDiffuse = true;
            materialArray.append(materialItem)
            
        }
        
        boxNode.geometry?.materials = materialArray
        
        let roAngle = (Float)(M_PI)/4
        let roYMat = SCNMatrix4MakeRotation(roAngle, 0, 1, 0)
        
        let roXMat = SCNMatrix4MakeRotation(roAngle, 1, 0, 0)
        
        let finalMat = SCNMatrix4Mult(roYMat, roXMat)
        
        boxNode.transform = finalMat
        
        mainBoxView.pointOfView = cameraNode

    }
    
    func yesButtonClicked() {
        buildQuestions()
        diceView.build2DCube(colorArray: cubeColorArray)
        
        buildBoxSides()
        mainBoxView.allowsCameraControl = false
        
    }
    
    func noButtonClicked() {
        print("no Button Clicked")
    }
    
    func tipsButtonClicked() {
        print("tips Button Clicked")
        mainBoxView.allowsCameraControl = true
    }
    

    
    func rotateXGesture (_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: sender.view)
        
        var newXAngle = (Float)(translation.y)*(Float)(M_PI)/180.0
        
        newXAngle += currentXAngle
        
        
        
        boxNode.transform = SCNMatrix4MakeRotation(newXAngle, 1, 0, 0)
        
        
        
        if(sender.state == UIGestureRecognizerState.ended) {
            
            currentXAngle = newXAngle
            
        }
        
    }
    
    func rotateYGesture (_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: sender.view)
        
        var newYAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        
        newYAngle += currentYAngle
        
        
        
        boxNode.transform = SCNMatrix4MakeRotation(newYAngle, 0, 1, 0)
        
        
        
        if(sender.state == UIGestureRecognizerState.ended) {
            
            currentYAngle = newYAngle
            
        }
        
  
        
    }
    
    
    func rotateGesture (_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: sender.view!)
        
        var newAngleX = (Float)(translation.y)*(Float)(M_PI)/180.0
        newAngleX += currentXAngle
        
        var newAngleY = (Float)(translation.x)*(Float)(M_PI)/180.0
        newAngleY += currentYAngle
        
        let matrix = boxNode.transform
        
        let rotateMatrix = SCNMatrix4Mult(SCNMatrix4MakeRotation(newAngleY, 0, 1, 0),SCNMatrix4MakeRotation(newAngleX, 1, 0, 0))
        
        let resultMatrix = SCNMatrix4Mult(matrix,rotateMatrix)


        
        boxNode.transform = rotateMatrix
        
        
    
        
        
        if(sender.state == UIGestureRecognizerState.ended) {
            currentXAngle = newAngleX
            currentYAngle = newAngleY
        }
    
    }
        
    
    
    

    
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject = hitResults[0]
            
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
