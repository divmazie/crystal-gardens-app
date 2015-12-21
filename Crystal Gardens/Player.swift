//
//  Player.swift
//  Crystal Gardens
//
//  Created by David on 12/17/15.
//  Copyright © 2015 David Mackenzie. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    let number: Int
    let color: UIColor
    let colorname: String
    var creepers: [Piece]
    var flowers: [Piece]
    
    init(number: Int, color: UIColor, colorname: String) {
        self.number = number
        self.creepers = [Piece]()
        self.flowers = [Piece]()
        self.color = color
        self.colorname = colorname
    }
    
    func addCreeper(piece: Piece) {
        creepers.append(piece)
    }
    
    func removeCreeper(piece: Piece) {
        creepers.removeObject(piece)
    }
    
    func addFlower(point: Piece) {
        flowers.append(point)
    }
    
    func endTurn() {
        decayCreepers()
        spawnCreepers()
    }
    
    func decayCreepers() {
        for creeper in creepers {
            creeper.creeperDecay()
        }
    }
    
    func spawnCreepers() {
        for creeper in creepers {
            creeper.creeperSpawn()
        }
    }
}

func ==(lhs: Player, rhs: Player) -> Bool {
    if lhs.number == rhs.number {
        return true
    } else {
        return false
    }
}
func !=(lhs: Player, rhs: Player) -> Bool {
    if lhs.number != rhs.number {
        return true
    } else {
        return false
    }
}