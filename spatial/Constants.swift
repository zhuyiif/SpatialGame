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

func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: UInt32) -> [Int] {
    var uniqueNumbers = Set<Int>()
    while uniqueNumbers.count < numberOfRandoms {
        uniqueNumbers.insert(Int(arc4random_uniform(maxNum + 1)) + minNum)
    }
    return Array(uniqueNumbers).shuffle
}


struct Constants {
    static let DICE_VIEW_MARGIN_RATIO = 0.05 // 10% margin
    static let MARGIN = 12
    static  let BACK_BUTTON_W = 44
    static let BACK_BUTTON_H = 34
}

