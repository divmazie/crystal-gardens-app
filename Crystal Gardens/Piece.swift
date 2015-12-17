//
//  Piece.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

class Piece {
    var column: Int
    var row: Int
    var sprite: SKNode?
    
    init(column: Int, row: Int, label: String) {
        self.column = column
        self.row = row
        
    }
}