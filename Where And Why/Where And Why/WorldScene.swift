//
//  WorldScene.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-05.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit

class WorldScene: GameScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        
        
        GameManager.Instance().playState = .World
    }
    
    
    override func prepareScene() {
        super.prepareScene()
        
        
        
        let gm = GameManager.Instance()
        gm.worldMngr.Room_Start()
        
        
    }
}

