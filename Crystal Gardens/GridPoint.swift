//
//  GridPoint.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

class GridPoint: Equatable {
    var column: Int
    var row: Int
    var grid: Grid
    var tile: SKShapeNode?
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
        tile = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        tile!.fillColor = SKColor.blackColor()
        parent.addChild(tile!)
    }
    
    func clicked(player: Player) -> Bool {
        if clearForCreeper(player) {
            makeCreeper(player)
        } else if (piece!.type == PieceType.Decay && player == occupyingPlayer!) {
            makeFlower()
        } else if (piece!.type == PieceType.Creeper && player == occupyingPlayer!) {
            clearPiece()
        } else {
            return false
        }
        return true
    }
    
    func clearPiece() {
        occupyingPlayer!.removeCreeper(piece!)
        occupyingPlayer = nil
        piece = nil
        tile!.fillColor = UIColor.blackColor()
        spawned = false
    }
    
    func makeCreeper(player: Player) {
        occupyingPlayer = player
        piece = Piece(point: self, type: PieceType.Creeper)
        tile!.fillColor = UIColor.yellowColor()
        player.addCreeper(piece!)
        spawned = false
    }
    
    func makeDecay() {
        tile!.fillColor = SKColor.blackColor()
        occupyingPlayer!.removeCreeper(piece!)
        piece = Piece(point: self, type: PieceType.Decay)
        spawned = false
    }
    
    func makeFlower() {
        piece = Piece(point: self, type: PieceType.Flower)
        occupyingPlayer!.addFlower(piece!)
        spawned = false
    }
    
    func clearForCreeper(player: Player) -> Bool {
        if (occupyingPlayer == nil || (piece!.type == PieceType.Decay && occupyingPlayer! != player)) {
            return true
        } else {
            return false
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