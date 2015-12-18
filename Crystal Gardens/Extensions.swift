//
//  Extensions.swift
//  Crystal Gardens
//
//  Created by David on 12/18/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import Foundation
import SpriteKit

extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}



func darkenUIColor(color: UIColor, amount: CGFloat) -> UIColor {
    let cicolor = CIColor(color: color)
    return UIColor(red: cicolor.red*amount, green: cicolor.green*amount, blue: cicolor.blue*amount, alpha: cicolor.alpha)
}

func lightenUIColor(color: UIColor, amount: CGFloat) -> UIColor {
    let cicolor = CIColor(color: color)
    let newRed = 1 - (1 - cicolor.red) * amount
    let newGreen = 1 - (1 - cicolor.green) * amount
    let newBlue = 1 - (1 - cicolor.blue) * amount
    return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: cicolor.alpha)
}