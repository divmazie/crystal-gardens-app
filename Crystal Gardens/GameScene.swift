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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init(size: CGSize) {
        currentPlayer = 0
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
        let myLabel = SKLabelNode()
        myLabel.name = "currentPlayer"
        myLabel.text = "Player 1's turn"
        myLabel.fontSize = 45
        myLabel.fontColor = UIColor.greenColor()
        myLabel.position = CGPoint(x: 0, y: 275)
        self.addChild(myLabel)
        
        let dirLabel = SKLabelNode()
        dirLabel.fontSize = 20
        dirLabel.position = CGPoint(x: 0, y: 225)
        switch grid.directionPreference {
        case .nbe:
            dirLabel.text = "North by East";
        case .nebn:
            dirLabel.text = "Northeast by North";
        case .nebe:
            dirLabel.text = "Northeast by East";
        case .ebn:
            dirLabel.text = "East by North";
        case .ebs:
            dirLabel.text = "East by South"
        case .sebe:
            dirLabel.text = "Southeast by East";
        case .sebs:
            dirLabel.text = "Southeast by South";
        case .sbe:
            dirLabel.text = "South by East";
        case .sbw:
            dirLabel.text = "South by West";
        case .swbs:
            dirLabel.text = "Southwest by South";
        case .swbw:
            dirLabel.text = "Southwest by West";
        case .wbs:
            dirLabel.text = "West by South"
        case .wbn:
            dirLabel.text = "West by North"
        case .nwbw:
            dirLabel.text = "Northwest by West";
        case .nwbn:
            dirLabel.text = "Northwest by North";
        case .nbw:
            dirLabel.text = "North by West";
        }
        self.addChild(dirLabel)
    }
    
    func assignPlayers() {
        players = [Player(number: 0, color: UIColor(red:0,green:1,blue:0,alpha:1), colorname: "green"),Player(number: 1, color: UIColor(red:0,green:0,blue:1,alpha:1), colorname: "blue")]
        currentPlayer = 0
    }
    
    func advanceTurn() {
        players[currentPlayer].endTurn()
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
                if gridpoint.clicked(players[currentPlayer]) {
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
