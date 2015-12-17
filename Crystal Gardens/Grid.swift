//
//  Level.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

let NumColumns = 9
let NumRows = 9

class Grid {
    private var board = Array2D<GridPoint>(columns: NumColumns, rows: NumRows)
    
    func pointAt(column: Int, row: Int) -> GridPoint? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return board[column, row]
    }
    
    func createGridPoints() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let point = GridPoint(column: column, row: row, label: "x")
                board[column, row] = point
            }
        }
    }
    
    func linkSKNodes(piecesLayer: SKNode, tileSize: CGFloat) {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                let point = pointAt(column, row: row)
                point!.linkSKNodes(piecesLayer)
                point!.node!.position = pointForColumn(column, row: row, tileSize: tileSize)
                point!.sprite!.name = String(column)+" "+String(row)
            }
        }
    }
    
    func pointForColumn(column: Int, row: Int, tileSize: CGFloat) -> CGPoint {
        return CGPoint(
            x: CGFloat(column)*tileSize + tileSize/2,
            y: CGFloat(row)*tileSize + tileSize/2)
    }
}