//
//  Piece.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

class Piece {
    let point: GridPoint
    let type: PieceType
    //var sprite: SKSpriteNode
    
    init(point: GridPoint, type: PieceType) {
        self.point = point
        self.type = type
        //sprite = SKSpriteNode(imageNamed: "\(type.rawValue)")
        //sprite!.size = CGSize(width: 32, height: 32)
        //tile!.addChild(sprite!)
    }
    
    deinit {
        //sprite.removeFromParent()
    }
}
