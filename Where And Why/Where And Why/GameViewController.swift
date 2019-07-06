//
//  GameViewController.swift
//  Where And Why
//
//  Created by Stephen Diep on 2019-06-25.
//  Copyright © 2019 DiepSigh. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gm = GameManager()
        gm.Initialize()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "World_Test") { // World_Test
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit // .resizeFill
                
                // Present the scene
                view.presentScene(scene)
                
                gm.currentScene = scene as? GameScene
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
        
        
        gm.currentScene?.prepareScene()
    }
    
    
}
