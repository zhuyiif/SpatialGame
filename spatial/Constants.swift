//
//  Constants.swift
//  spatial
//
//  Created by yi zhu on 2/23/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation

enum DiceDirection : Int {
    case front = 0,
    right,
    back,
    left,
    top,
    bottom
}

struct RotationXYNum : Hashable,Equatable{
    var x:Int
    var y:Int
    
    var hashValue : Int {
        get {
            return x*10 + y
        }
    }
    
    static func ==(lhs: RotationXYNum, rhs: RotationXYNum) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}


struct VisiableSides {
    var side1:DiceDirection
    var side2:DiceDirection
    var side3:DiceDirection
    
  
}








struct Constants {
    static let DICE_VIEW_MARGIN_RATIO = 0.05 // 10% margin
}

