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
    
    var currentYAngle: Float = 0.0
    
    var currentXAngle: Float = 0.0
   
    
    
    var boxNode: SCNNode = SCNNode()
    
    var box1Node: SCNNode = SCNNode()
    var box2Node: SCNNode = SCNNode()
    var box3Node: SCNNode = SCNNode()
    var box4Node: SCNNode = SCNNode()
    
    var cubeColorArray:[UIColor]  = []
    
    var mainBoxView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // create a new scene
       // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
       
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        let boxGeometry = SCNBox(width: 5.0, height: 5.0, length: 5.0, chamferRadius: 0.2)
        boxNode = SCNNode(geometry: boxGeometry)
        scene.rootNode.addChildNode(boxNode)
        
        let box1Geometry = SCNBox(width: 2.0, height: 2.0, length: 2.0, chamferRadius: 0.1)
        box1Node = SCNNode(geometry: box1Geometry)
        scene.rootNode.addChildNode(box1Node)
        box1Node.position = SCNVector3Make(0, -4, 0);
      
        
        
        let greenMaterial             =  SCNMaterial()
        greenMaterial.diffuse.contents          = UIColor.green
        greenMaterial.locksAmbientWithDiffuse     = true;
        
        
        let redMaterial                = SCNMaterial();
        redMaterial.diffuse.contents            = UIColor.red;
        redMaterial.locksAmbientWithDiffuse     = true;
        
        let blueMaterial                = SCNMaterial();
        blueMaterial.diffuse.contents            = UIColor.blue;
        blueMaterial.locksAmbientWithDiffuse     = true;
        
        let yellowMaterial                = SCNMaterial();
        yellowMaterial.diffuse.contents            = UIColor.yellow;
        yellowMaterial.locksAmbientWithDiffuse     = true;
        
        let purpleMaterial                = SCNMaterial();
        purpleMaterial.diffuse.contents            = UIColor.purple;
        purpleMaterial.locksAmbientWithDiffuse     = true;
        
        let magentaMaterial                = SCNMaterial();
        magentaMaterial.diffuse.contents            = UIColor.gray;
        magentaMaterial.locksAmbientWithDiffuse     = true;

        
        
        boxNode.geometry?.materials = [greenMaterial,  redMaterial,    blueMaterial,
                                       yellowMaterial, purpleMaterial, magentaMaterial]
        
        box1Node.geometry?.materials = [greenMaterial,  redMaterial,    blueMaterial,
                                       yellowMaterial, purpleMaterial, magentaMaterial]
        box2Node.geometry?.materials = [greenMaterial,  redMaterial,    blueMaterial,
                                       yellowMaterial, purpleMaterial, magentaMaterial]
        box3Node.geometry?.materials = [greenMaterial,  redMaterial,    blueMaterial,
                                       yellowMaterial, purpleMaterial, magentaMaterial]
        box4Node.geometry?.materials = [greenMaterial,  redMaterial,    blueMaterial,
                                       yellowMaterial, purpleMaterial, magentaMaterial]
        
        
        
    

        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
        
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
      //  scnView.addGestureRecognizer(tapGesture)
        
   
        
//        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(rotateGesture(_:)))
//        panRecognizer.maximumNumberOfTouches = 1
//        panRecognizer.minimumNumberOfTouches = 1
//        
//        scnView.addGestureRecognizer(panRecognizer)
        
        scnView.autoenablesDefaultLighting = true
        
        cubeColorArray.append(UIColor.green)
        cubeColorArray.append(UIColor.red)
        cubeColorArray.append(UIColor.blue)
        cubeColorArray.append(UIColor.yellow)
        cubeColorArray.append(UIColor.purple)
        cubeColorArray.append(UIColor.gray)
        
        
        

        
        let diceView = DiceView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/3))
        self.view.addSubview(diceView)
        diceView.build2DCube(colorArray: cubeColorArray)
        
        mainBoxView.frame = CGRect(x: 0, y: self.view.frame.height/3, width: self.view.frame.width, height: self.view.frame.height/3)
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
