//
//  GridPoint.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

class GridPoint {
    var column: Int
    var row: Int
    var node: SKNode?
    var sprite: SKShapeNode?
    var piece: Piece?
    
    init(column: Int, row: Int, label: String) {
        self.column = column
        self.row = row
    }
    
    func linkSKNodes(parent: SKNode) {
        node = SKNode()
        parent.addChild(node!)
        sprite = SKShapeNode(rectOfSize: CGSize(width: 5, height: 5))
        sprite!.fillColor = SKColor.whiteColor()
        node!.addChild(sprite!)
    }
    
    func clicked() {
        sprite!.fillColor = SKColor.blueColor()
    }
}