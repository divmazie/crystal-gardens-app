//
//  GridPoint.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

enum Piece {
    case Post, Growth, Wall, Creeper, Decay, Flower
}

class GridPoint: Equatable {
    var column: Int
    var row: Int
    var grid: Grid
    var node: SKNode?
    var tile: SKShapeNode?
    var sprite: SKSpriteNode?
    var occupyingPlayer: Player?
    var piece: Piece?
    var spawned: Bool
    
    init(column: Int, row: Int, grid: Grid) {
        self.column = column
        self.row = row
        self.grid = grid
        occupyingPlayer = nil
        spawned = false
    }
    
    func linkSKNodes(parent: SKNode) {
        node = SKNode()
        parent.addChild(node!)
        tile = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        tile!.fillColor = SKColor.blackColor()
        node!.addChild(tile!)
    }
    
    func clicked(player: Player) -> Bool {
        if clearForCreeper(player) {
            makeCreeper(player)
        } else if (piece == Piece.Decay && player == occupyingPlayer!) {
            makeFlower()
        } else if (piece == Piece.Creeper && player == occupyingPlayer!) {
            clearPiece()
        } else {
            return false
        }
        return true
    }
    
    func clearPiece() {
        occupyingPlayer!.removeCreeper(self)
        occupyingPlayer = nil
        piece = nil
        tile!.fillColor = UIColor.blackColor()
        spawned = false
    }
    
    func addSprite(imageNamed: String) {
        if (sprite != nil) {
            sprite!.removeFromParent()
        }
        sprite = SKSpriteNode(imageNamed: imageNamed)
        sprite!.size = CGSize(width: 32, height: 32)
        tile!.addChild(sprite!)
    }
    
    func makeCreeper(player: Player) {
        piece = Piece.Creeper
        occupyingPlayer = player
        addSprite("creeper_\(player.colorname).png")
        tile!.fillColor = UIColor.yellowColor()
        player.addCreeper(self)
        spawned = false
    }
    
    func makeDecay() {
        addSprite("decay_\(occupyingPlayer!.colorname).png")
        tile!.fillColor = SKColor.blackColor()
        occupyingPlayer!.removeCreeper(self)
        piece = Piece.Decay
        spawned = false
    }
    
    func makeFlower() {
        addSprite("flower_\(occupyingPlayer!.colorname).png")
        occupyingPlayer!.addFlower(self)
        piece = Piece.Flower
        spawned = false
    }
    
    func clearForCreeper(player: Player) -> Bool {
        if (occupyingPlayer == nil || (piece! == Piece.Decay && occupyingPlayer! != player)) {
            return true
        } else {
            return false
        }
    }
    
    func creeperSpawn() {
        if (!spawned) {
            let nextpoint = grid.nextCreeperPoint(column, row: row, player: occupyingPlayer!)
            if (nextpoint != nil) {
                nextpoint?.makeCreeper(occupyingPlayer!)
            }
            spawned = true
            tile!.fillColor = UIColor.blackColor()
        }
    }
    
    func creeperDecay() {
        let nextpoint = grid.nextCreeperPoint(column, row: row, player: occupyingPlayer!)
        if (nextpoint == nil) {
            makeDecay()
        }
    }
}

func ==(lhs: GridPoint, rhs: GridPoint) -> Bool {
    if lhs.column == rhs.column && lhs.row == rhs.row {
        return true
    } else {
        return false
    }
}