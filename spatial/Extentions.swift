//
//  Extentions.swift
//  spatial
//
//  Created by yi zhu on 2/23/17.
//  Copyright © 2017 zackzhu. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func localized(withComment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
}

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

extension UIButton {
    
    func make3D(){
        self.layer.cornerRadius = 3.0;
        
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor(colorLiteralRed: 100.0 / 255.0, green: 0, blue: 0, alpha: 1).cgColor
            
        
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowRadius = 1.0;
        
        self.layer.shadowOffset = CGSize(width: 0, height: 3);
    }
    
}
