//
//  Piece.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

enum PieceType {
    case Post, Growth, Wall, Creeper, Decay, Flower
    func toString() -> String {
        switch self {
        case Post:
            return "post"
        case Growth:
            return "growth"
        case Wall:
            return "wall"
        case Creeper:
            return "creeper"
        case Decay:
            return "decay"
        case Flower:
            return "flower"
        }
    }
}

class Piece: Equatable {
    let point: GridPoint
    let type: PieceType
    let sprite: SKSpriteNode
    var spawned: Bool
    
    init(point: GridPoint, type: PieceType) {
        self.point = point
        self.type = type
        sprite = SKSpriteNode(imageNamed: "\(type.toString())_\(point.occupyingPlayer!.colorname).png")
        sprite.size = CGSize(width: 32, height: 32)
        point.tile!.addChild(sprite)
        spawned = false
    }
    
    deinit {
        sprite.removeFromParent()
    }
    
    func creeperSpawn() {
        if (!spawned) {
            let nextpoint = point.grid.nextCreeperPoint(point.column, row: point.row, player: point.occupyingPlayer!)
            if (nextpoint != nil) {
                nextpoint?.makeCreeper(point.occupyingPlayer!)
            }
            spawned = true
            point.tile!.fillColor = UIColor.blackColor()
        }
    }
    
    func creeperDecay() {
        let nextpoint = point.grid.nextCreeperPoint(point.column, row: point.row, player: point.occupyingPlayer!)
        if (nextpoint == nil) {
            point.makeDecay()
        }
    }
}

func ==(rhs: Piece, lhs: Piece) -> Bool {
    if (rhs.type == lhs.type && rhs.point == lhs.point) {
        return true
    } else {
        return false
    }
}
