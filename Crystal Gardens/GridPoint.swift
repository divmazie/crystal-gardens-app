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
    var sprite: SKShapeNode?
    var occupyingPlayer: Player?
    var piece: Piece?
    
    init(column: Int, row: Int, grid: Grid) {
        self.column = column
        self.row = row
        self.grid = grid
        self.occupyingPlayer = nil
    }
    
    func linkSKNodes(parent: SKNode) {
        node = SKNode()
        parent.addChild(node!)
        sprite = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        sprite!.fillColor = SKColor.blackColor()
        node!.addChild(sprite!)
    }
    
    func clicked(player: Player) {
        if clearForCreeper(player) {
            makeCreeper(player)
        } else if (piece == Piece.Decay && player == occupyingPlayer!) {
            makeFlower()
        }
    }
    
    func makeCreeper(player: Player) {
        piece = Piece.Creeper
        occupyingPlayer = player
        sprite!.fillColor = player.color
        player.addCreeper(self)
    }
    
    func makeDecay() {
        occupyingPlayer!.removeCreeper(self)
        piece = Piece.Decay
        sprite!.fillColor = darkenUIColor((occupyingPlayer?.color)!, amount: 0.3)
    }
    
    func makeFlower() {
        occupyingPlayer!.addFlower(self)
        piece = Piece.Flower
        sprite!.fillColor = lightenUIColor((occupyingPlayer?.color)!, amount: 0.3)
    }
    
    func clearForCreeper(player: Player) -> Bool {
        if (occupyingPlayer == nil || (piece! == Piece.Decay && occupyingPlayer! != player)) {
            return true
        } else {
            return false
        }
    }
    
    func creeperSpawn() {
        let nextpoint = grid.nextCreeperPoint(column, row: row, player: occupyingPlayer!)
        if (nextpoint != nil) {
            nextpoint?.makeCreeper(occupyingPlayer!)
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