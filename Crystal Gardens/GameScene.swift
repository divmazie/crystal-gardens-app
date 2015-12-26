//
//  GameScene.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright (c) 2015 David Mackenzie. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var grid: Grid!
    
    let TileSize: CGFloat = 32.0
    
    let gameLayer = SKNode()
    let piecesLayer = SKNode()
    var players: [Player]!
    var currentPlayer: Int
    var turn: Int
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        currentPlayer = 0
        turn = 0
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -TileSize * CGFloat(NumColumns) / 2,
            y: -TileSize * CGFloat(NumRows) / 2)
        
        piecesLayer.position = layerPosition
        piecesLayer.name = "piecesLayer"
        gameLayer.addChild(piecesLayer)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let dirLabel = SKLabelNode()
        dirLabel.fontSize = 20
        dirLabel.position = CGPoint(x: 0, y: 225)
        dirLabel.text = grid.directionPreference.label()
        self.addChild(dirLabel)
        
    }
    
    func assignPlayers() {
        players = [Player(number: 0, color: UIColor(red:0,green:1,blue:0,alpha:1), colorname: "green"),Player(number: 1, color: UIColor(red:0,green:0,blue:1,alpha:1), colorname: "blue")]
        currentPlayer = 0
        let myLabel = SKLabelNode()
        myLabel.name = "currentPlayer"
        myLabel.text = "Player \(currentPlayer+1)'s turn"
        myLabel.fontSize = 45
        myLabel.fontColor = players[currentPlayer].color
        myLabel.position = CGPoint(x: 0, y: 275)
        self.addChild(myLabel)
        for player in players {
            let playerLabel = SKLabelNode()
            playerLabel.name = "player\(player.number)Label"
            playerLabel.fontSize = 20
            playerLabel.fontColor = lightenUIColor(player.color, amount: 0.4)
            playerLabel.position = CGPoint(x: -100+player.number*200, y: -220)
            playerLabel.text = "Vines: 0 Flowers: 0"
            self.addChild(playerLabel)
        }
    }
    
    func advanceTurn() {
        players[currentPlayer].endTurn(turn)
        let playerLabel = self.childNodeWithName("player\(currentPlayer)Label") as! SKLabelNode
        playerLabel.text = "Vines: \(players[currentPlayer].creepers.count) Flowers: \(players[currentPlayer].flowers.count)"
        turn++
        currentPlayer++
        if (currentPlayer >= players.count) {
            currentPlayer = 0
        }
        let myLabel = self.childNodeWithName("currentPlayer") as! SKLabelNode
        myLabel.fontColor = lightenUIColor(players[currentPlayer].color, amount: 0.3)
        myLabel.text = "Player \(currentPlayer+1)'s turn"
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        let touch = touches.first
        let location = touch!.locationInNode(piecesLayer)
        let (success, column, row) = convertPoint(location)
        if success {
            if let gridpoint = grid.pointAt(column, row: row) {
                if gridpoint.clicked(players[currentPlayer], turn: turn) {
                    advanceTurn()
                }
            }
        } else {
            advanceTurn()
        }
        
        /*
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
        */
    }
    
    func convertPoint(point: CGPoint) -> (success: Bool, column: Int, row: Int) {
        if point.x >= 0 && point.x < CGFloat(NumColumns)*TileSize &&
            point.y >= 0 && point.y < CGFloat(NumRows)*TileSize {
                return (true, Int(point.x / TileSize), Int(point.y / TileSize))
        } else {
            return (false, 0, 0)  // invalid location
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
