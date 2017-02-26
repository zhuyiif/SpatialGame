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
import ChameleonFramework
import Material
import SCLAlertView



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
    
    
    fileprivate func prepareRaisedButton() {
      
        
        
    }
    
    
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
        self.view.backgroundColor = UIColor.flatBlack
    }
    
    func setupDiceView() {
        
        diceView = DiceView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height*4/10.0))
        self.view.addSubview(diceView)
        diceView.backgroundColor = UIColor.flatBlack
        
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
        
        
        mainBoxView.frame = CGRect(x: 0, y: self.diceView.frame.height , width: self.view.frame.width, height: self.view.frame.height*4/10.0)
        mainBoxView.backgroundColor = UIColor.white
        
        self.view.addSubview(mainBoxView)
        
        // retrieve the SCNView
        let scnView = mainBoxView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        //scnView.allowsCameraControl = true
        
        
        // configure the view
        scnView.backgroundColor = UIColor.flatBlack
        
        scnView.autoenablesDefaultLighting = true
        
    }
    
    func setupQuestionButtonsView() {
        questionButtonsView = QuestionAndButtonsView(frame: CGRect(x: 0, y: self.diceView.frame.height + self.mainBoxView.frame.height , width: self.view.frame.width, height: self.view.frame.height*3/10))
        
        self.view.addSubview(questionButtonsView)
        
        questionButtonsView.backgroundColor = UIColor.flatOrange
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
                cubeColorArray.append(UIColor.flatGreen)
            case 1:
                cubeColorArray.append(UIColor.flatRed)
            case 2:
                cubeColorArray.append(UIColor.flatBlue)
            case 3:
                cubeColorArray.append(UIColor.flatYellow)
            case 4:
                cubeColorArray.append(UIColor.flatPurple)
            case 5:
                cubeColorArray.append(UIColor.flatGray)
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
        
        
        var rotateXNumber = 1
        var rotateYNumber = 1
        
        if currentAnswer {
            
            rotateXNumber = Int(arc4random_uniform(4))
            rotateYNumber = Int(arc4random_uniform(4))
            
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
        }
        else {
            rotateYNumber = Int(arc4random_uniform(2))
            if rotateYNumber == 0 {
                rotateYNumber = 1
                
            }
            else {
                rotateYNumber = 3
            }
            
        }
        
        let roYAngle = (Float)(M_PI)/4 * (Float)(rotateYNumber)
        let roYMat = SCNMatrix4MakeRotation(roYAngle, 0, 1, 0)
        
        let roXAngle = (Float)(M_PI)/4 * (Float)(rotateXNumber)
        let roXMat = SCNMatrix4MakeRotation(roXAngle, 1, 0, 0)
        
        var finalMat :SCNMatrix4 = SCNMatrix4Identity
        
        finalMat  = SCNMatrix4Mult(roYMat, roXMat)
        
        
        
        print("X: " + rotateXNumber.description + " Y:" + rotateYNumber.description)
        
        boxNode.transform = finalMat
        
        
        
        
        
        
        
        
        
        
        if currentAnswer {
            print("correct")
            
            //disable this feature for now
            let isUpsideDown = 0
            
            if isUpsideDown == 1 {
                print("upside down")
            }
            else {
                print("normal")
            }
            
            var switchIn: Int = DiceDirection.bottom.rawValue
            var switchOut: Int = DiceDirection.top.rawValue
            
            
            for (index,element) in cubeColorArray.enumerated() {
                let materialItem = SCNMaterial()
                
                if isUpsideDown == 1 {
                    if index == switchIn {
                        materialItem.diffuse.contents = cubeColorArray[switchOut]
                    }
                    else if index == switchOut {
                        materialItem.diffuse.contents = cubeColorArray[switchIn]
                    }
                    else {
                        materialItem.diffuse.contents = element
                        
                    }

                    
                }
                else
                {
                
                
                materialItem.diffuse.contents = element
                }
                
                materialItem.locksAmbientWithDiffuse = true;
                materialArray.append(materialItem)
            }
            
        }
        else {
            print("wrong")
            //need switch visiable sides
            
            
            var switchIn: Int = 0
            var switchOut: Int = 0
            
            if (rotateYNumber == 1) {
                //switch back left
                switchIn = DiceDirection.back.rawValue
                switchOut = DiceDirection.left.rawValue
            }
            else {
                switchIn = DiceDirection.back.rawValue
                switchOut = DiceDirection.right.rawValue
                
            }
            
            for (index,element) in cubeColorArray.enumerated() {
                let materialItem = SCNMaterial()
                
                
                if index == switchIn {
                    materialItem.diffuse.contents = cubeColorArray[switchOut]
                }
                else if index == switchOut {
                    materialItem.diffuse.contents = cubeColorArray[switchIn]
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
         
            
            SCLAlertView().showTitle(
                "Congratulations", // Title of view
                subTitle: "You are Awesome.", // String of view
                duration: 2.0, // Duration to show before closing automatically, default: 0.0
                completeText: "Done", // Optional button value, default: ""
                style: .success, // Styles - see below.
                colorStyle: 0xA429FF,
                colorTextButton: 0xFFFFFF
                ).setDismissBlock {
                    self.nextButtonClicked()
            }
            
            
        }
        else {
            
            SCLAlertView().showTitle(
                "Sorry", // Title of view
                subTitle: "You are wrong.", // String of view
                duration: 2.0, // Duration to show before closing automatically, default: 0.0
                completeText: "Done", // Optional button value, default: ""
                style: .error, // Styles - see below.
                colorStyle: UInt(UIColor.flatRed.hexValue(), radix: 16),
                colorTextButton: UInt(UIColor.flatRed.hexValue(), radix: 16)
            )
            

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
        
        SCLAlertView().showTitle(
            "Tips", // Title of view
            subTitle: "You can use finger rotate the box.", // String of view
            duration: 2.0, // Duration to show before closing automatically, default: 0.0
            completeText: "Done", // Optional button value, default: ""
            style: .success, // Styles - see below.
            colorStyle: 0xA429FF,
            colorTextButton: 0xFFFFFF
            ).setDismissBlock {
                
                self.animationBox();
                self.mainBoxView.allowsCameraControl = true
                
        }
        
     
    }
    func nextButtonClicked() {
        
        buildQuestions()
        mainBoxView.allowsCameraControl = false
        
    }
    
    func animationBox() {
        
        let boxRatation = SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 1);
        boxNode.runAction(boxRatation)
        
        
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
