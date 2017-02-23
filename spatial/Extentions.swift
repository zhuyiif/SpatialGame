//
//  Extentions.swift
//  spatial
//
//  Created by yi zhu on 2/23/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation

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
