//
//  GameViewController.swift
//  Crystal Gardens
//
//  Created by David on 12/16/15.
//  Copyright (c) 2015 David Mackenzie. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var grid: Grid!
    
    func beginGame() {
        grid.createGridPoints()
        grid.linkSKNodes(scene.piecesLayer, tileSize: scene.TileSize)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        grid = Grid()
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true

        scene = GameScene(size: skView.bounds.size)
        scene.grid = grid
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
        beginGame()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
