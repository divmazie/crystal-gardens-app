//
//  Grid.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

let NumColumns = 11
let NumRows = 11

enum DirectionPreference: UInt32 {
    case nbe, nebn, nebe, ebn, ebs, sebe, sebs, sbe, sbw, swbs, swbw, wbs, wbn, nwbw, nwbn, nbw
    static func randomDirectionPreference() -> DirectionPreference {
        // pick and return a new value
        let rand = arc4random_uniform(16)
        return DirectionPreference(rawValue: rand)!
    }
}

class Grid {
    private var board = Array2D<GridPoint>(columns: NumColumns, rows: NumRows)
    let directionPreference: DirectionPreference
    let directionOrder: [[Int]]
    
    init() {
        directionPreference = DirectionPreference.randomDirectionPreference()
        switch directionPreference {
        case .nbe:
            directionOrder = [[0,1], [1,1], [-1,1], [1,0], [-1,0], [1,-1], [-1,-1], [0,-1]]
        case .nebn:
            directionOrder = [[1,1], [0,1], [1,0], [-1,1], [1,-1], [-1,0], [0,-1], [-1,-1]]
        case .nebe:
            directionOrder = [[1,1], [1,0], [0,1], [1,-1], [-1,1], [0,-1], [-1,0], [-1,-1]]
        case .ebn:
            directionOrder = [[1,0], [1,1], [1,-1], [0,1], [0,-1], [-1,1], [-1,-1], [-1,0]]
        case .ebs:
            directionOrder = [[1,0], [1,-1], [1,1], [0,-1], [0,1], [-1,-1], [-1,1], [-1,0]]
        case .sebe:
            directionOrder = [[1,-1], [1,0], [0,-1], [1,1], [-1,-1], [0,1], [-1,0], [-1,1]]
        case .sebs:
            directionOrder = [[1,-1], [0,-1], [1,0], [-1,-1], [1,1], [-1,0], [0,1], [-1,1]]
        case .sbe:
            directionOrder = [[0,-1], [1,-1], [-1,-1], [1,0], [-1,0], [1,1], [-1,1], [0,1]]
        case .sbw:
            directionOrder = [[0,-1], [-1,-1], [1,-1], [-1,0], [1,0], [-1,1], [1,1], [0,1]]
        case .swbs:
            directionOrder = [[-1,-1], [0,-1], [-1,0], [1,-1], [-1,1], [1,0], [0,1], [1,1]]
        case .swbw:
            directionOrder = [[-1,-1], [-1,0], [0,-1], [-1,1], [1,-1], [0,1], [1,0], [1,1]]
        case .wbs:
            directionOrder = [[-1,0], [-1,-1], [-1,1], [0,-1], [0,1], [1,-1], [1,1], [1,0]]
        case .wbn:
            directionOrder = [[-1,0], [-1,1], [-1,-1], [0,1], [0,-1], [1,1], [1,-1], [1,0]]
        case .nwbw:
            directionOrder = [[-1,1], [-1,0], [0,1], [-1,-1], [1,1], [0,-1], [1,0], [1,-1]]
        case .nwbn:
            directionOrder = [[-1,1], [0,1], [-1,0], [1,1], [-1,-1], [1,0], [0,-1], [1,-1]]
        case .nbw:
            directionOrder = [[0,1], [-1,1], [1,1], [-1,0], [1,0], [-1,-1], [1,-1], [0,-1]]
        }
    }
    
    func pointAt(column: Int, row: Int) -> GridPoint? {
        //assert(column >= 0 && column < NumColumns)
        //assert(row >= 0 && row < NumRows)
        if (column >= 0 && column < NumColumns && row >= 0 && row < NumRows) {
            return board[column, row]
        } else {
            return nil
        }
    }
    
    func createGridPoints() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let point = GridPoint(column: column, row: row, grid: self)
                board[column, row] = point
            }
        }
    }
    
    func linkSKNodes(piecesLayer: SKNode, tileSize: CGFloat) {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let point = pointAt(column, row: row)
                point!.linkSKNodes(piecesLayer)
                point!.tile!.position = pointForColumn(column, row: row, tileSize: tileSize)
                point!.tile!.name = String(column)+" "+String(row)
            }
        }
    }
    
    func pointForColumn(column: Int, row: Int, tileSize: CGFloat) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*tileSize + tileSize/2,
            y: CGFloat(row)*tileSize + tileSize/2)
    }
    
    func nextCreeperPoint(column: Int, row: Int, player: Player) -> GridPoint? {
        for direction in directionOrder {
            let nextPoint = pointAt(column + direction[0], row: row + direction[1])
            if (nextPoint != nil && nextPoint!.clearForCreeper(player)) {
                return nextPoint
            }
        }
        return nil
    }
}