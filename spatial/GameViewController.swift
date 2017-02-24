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



class GameViewController: UIViewController {
    
    var currentAnswer: Bool = false
    
    
    var boxNode: SCNNode = SCNNode()
    
    var cubeColorArray:[UIColor]  = []
    var wrongCubeColorArray:[UIColor]  = []
    
    var mainBoxView: SCNView = SCNView()
    
    var questionBoxView: SCNView = SCNView()
    
    var diceView: DiceView = DiceView()
    
    var questionButtonsView: QuestionAndButtonsView = QuestionAndButtonsView()
    
    var cameraNode = SCNNode()
    
    var diceRotateSidesDictionary = [RotationXYNum : VisiableSides]()
    
    
    func initDiceDicData() {
        
        diceRotateSidesDictionary[RotationXYNum(x: 1,y: 1)] = VisiableSides(side1: .left, side2: .top, side3: .front)
        diceRotateSidesDictionary[RotationXYNum(x: 3,y: 1)] = VisiableSides(side1: .top, side2: .back, side3: .right)
        diceRotateSidesDictionary[RotationXYNum(x: 5,y: 1)] = VisiableSides(side1: .bottom, side2: .back, side3: .right)
        diceRotateSidesDictionary[RotationXYNum(x: 7,y: 1)] = VisiableSides(side1: .left, side2: .bottom, side3: .front)
        
        diceRotateSidesDictionary[RotationXYNum(x: 1,y: 3)] = VisiableSides(side1: .top, side2: .back, side3: .left)
        diceRotateSidesDictionary[RotationXYNum(x: 3,y: 3)] = VisiableSides(side1: .top, side2: .right, side3: .front)
        diceRotateSidesDictionary[RotationXYNum(x: 5,y: 3)] = VisiableSides(side1: .bottom, side2: .right, side3: .front)
        diceRotateSidesDictionary[RotationXYNum(x: 7,y: 3)] = VisiableSides(side1: .bottom, side2: .back, side3: .left)
        
        diceRotateSidesDictionary[RotationXYNum(x: 1,y: 5)] = VisiableSides(side1: .top, side2: .right, side3: .back)
        diceRotateSidesDictionary[RotationXYNum(x: 3,y: 5)] = VisiableSides(side1: .top, side2: .front, side3: .left)
        diceRotateSidesDictionary[RotationXYNum(x: 5,y: 5)] = VisiableSides(side1: .bottom, side2: .front, side3: .left)
        diceRotateSidesDictionary[RotationXYNum(x: 7,y: 5)] = VisiableSides(side1: .bottom, side2: .right, side3: .back)
        
        diceRotateSidesDictionary[RotationXYNum(x: 1,y: 7)] = VisiableSides(side1: .top, side2: .front, side3: .right)
        diceRotateSidesDictionary[RotationXYNum(x: 3,y: 7)] = VisiableSides(side1: .top, side2: .left, side3: .back)
        diceRotateSidesDictionary[RotationXYNum(x: 5,y: 7)] = VisiableSides(side1: .bottom, side2: .left, side3: .back)
        diceRotateSidesDictionary[RotationXYNum(x: 7,y: 7)] = VisiableSides(side1: .bottom, side2: .front, side3: .right)
        
        
        
    }
    
    func setupViews() {
        setupDiceView()
        setupMainBoxView()
        setupQuestionButtonsView()
    }
    
    func setupDiceView() {
        
        diceView = DiceView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3))
        self.view.addSubview(diceView)
        diceView.backgroundColor = UIColor.black
        
    }
    
    func setupMainBoxView() {
        // create a new scene
        let scene = SCNScene()
        
        // create and add a camera to the scene
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        let boxGeometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.2)
        boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        
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
        
    }
    
    func setupQuestionButtonsView() {
        questionButtonsView = QuestionAndButtonsView(frame: CGRect(x: 0, y: self.view.frame.height/3*2 , width: self.view.frame.width, height: self.view.frame.height/3))
        
        self.view.addSubview(questionButtonsView)
        
        questionButtonsView.backgroundColor = UIColor.orange
        questionButtonsView.yesButton.addTarget(self, action:#selector(self.yesButtonClicked), for: .touchUpInside)
        questionButtonsView.noButton.addTarget(self, action:#selector(self.noButtonClicked), for: .touchUpInside)
        questionButtonsView.tipsButton.addTarget(self, action:#selector(self.tipsButtonClicked), for: .touchUpInside)
        questionButtonsView.tryNext.addTarget(self, action:#selector(self.nextButtonClicked), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDiceDicData()
        setupViews()
        
        buildQuestions()
        
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
        
        
        diceView.build2DCube(colorArray: cubeColorArray)
        buildBoxSides()
        
        
    }
    
    
    func buildBoxSides() {
        var materialArray:[SCNMaterial] = []
        
        //        if !self.currentAnswer {
        //
        //            for (index,element) in cubeColorArray.enumerated() {
        //                let materialItem = SCNMaterial()
        //
        //                if(index == 0) {
        //                    materialItem.diffuse.contents  =  cubeColorArray[1]
        //                }
        //                else if(index == 1) {
        //                    materialItem.diffuse.contents  =  cubeColorArray[0]
        //                }
        //                else {
        //                    materialItem.diffuse.contents = element
        //                }
        //                materialItem.locksAmbientWithDiffuse = true;
        //                materialArray.append(materialItem)
        //
        //            }
        //        }
        //        else
        
        //    {
    
     
        
        
        var rotateXNumber = arc4random_uniform(4)
        var rotateYNumber = arc4random_uniform(4)
        
        switch rotateXNumber {
        case 0:
            rotateXNumber = 1
        case 1:
            rotateXNumber = 3
        case 2:
            rotateXNumber = 5
        case 3:
            rotateXNumber = 7
        default:
            print("error")
        }
        
        switch rotateYNumber {
        case 0:
            rotateYNumber = 1
        case 1:
            rotateYNumber = 3
        case 2:
            rotateYNumber = 5
        case 3:
            rotateYNumber = 7
        default:
            print("error")
        }
        
        let roYAngle = (Float)(M_PI)/4 * (Float)(rotateYNumber)
        let roYMat = SCNMatrix4MakeRotation(roYAngle, 0, 1, 0)
        
        let roXAngle = (Float)(M_PI)/4 * (Float)(rotateXNumber)
        let roXMat = SCNMatrix4MakeRotation(roXAngle, 1, 0, 0)
        
        let finalMat = SCNMatrix4Mult(roYMat, roXMat)
        
        
        print("X: " + rotateXNumber.description + " Y:" + rotateYNumber.description)
        
        boxNode.transform = finalMat
        
        
    
        
        //   }
        
       
        
        
        
        if currentAnswer {
            print("correct")
            for (_,element) in cubeColorArray.enumerated() {
                let materialItem = SCNMaterial()
                
                
                materialItem.diffuse.contents = element
                
                materialItem.locksAmbientWithDiffuse = true;
                materialArray.append(materialItem)
            }
            
        }
        else {
            print("wrong")
            //need switch visiable sides
            
            let ratationData: RotationXYNum = RotationXYNum(x:Int( rotateXNumber), y: Int(rotateYNumber))
            
            let visiableData = diceRotateSidesDictionary[ratationData]
            
         
            for (index,element) in cubeColorArray.enumerated() {
                let materialItem = SCNMaterial()
                
                if index == visiableData?.side1.rawValue {
                    materialItem.diffuse.contents = cubeColorArray[(visiableData?.side2.rawValue)!]
                }
                else if index == visiableData?.side2.rawValue {
                    materialItem.diffuse.contents = cubeColorArray[(visiableData?.side1.rawValue)!]
                }
                else {
                    materialItem.diffuse.contents = element
                    
                }
                
                
               
                
                materialItem.locksAmbientWithDiffuse = true;
                materialArray.append(materialItem)
            }
            
            
            
        }
        
        
         boxNode.geometry?.materials = materialArray
        
        
        
        mainBoxView.pointOfView = cameraNode
        
    }
    
    func showAlert(isRight:Bool) {
        
        
        if (isRight) {
            let alertController = UIAlertController(title: "Congrat", message:
                "You are Awesome", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Sorry", message:
                "Try next", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func yesButtonClicked() {
        
        
        showAlert(isRight: self.currentAnswer)
        
        
        
    }
    
    func noButtonClicked() {
        showAlert(isRight: !self.currentAnswer)
        print("no Button Clicked")
    }
    
    func tipsButtonClicked() {
        print("tips Button Clicked")
        mainBoxView.allowsCameraControl = true
    }
    func nextButtonClicked() {
        
        buildQuestions()
        mainBoxView.allowsCameraControl = false
        
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
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
