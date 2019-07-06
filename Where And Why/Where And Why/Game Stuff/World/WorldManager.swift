//
//  WorldManager.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-07-03.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit

class WorldManager {
    
    var player: WorldPlayer!
    var rg: Roomgrid!
    
    var isActivated: Bool = false
    
    
    
    init() {
        rg = Roomgrid()
    }
    
    
    
    func doUpdate(_ currentTime: TimeInterval) {
        if (player != nil) {
            player.doUpdate(currentTime)
        }
    }
    
    
    
    func Room_Start() {
        let gm = GameManager.Instance()
        
        
        rg.tilemap = gm.currentScene?.childNode(withName: "worldgrid") as? SKTileMapNode
        rg.solidmap = gm.currentScene?.childNode(withName: "solidgrid") as? SKTileMapNode
        
        
        rg.Reconstruct(Int((gm.currentScene?.size.width)! / CGFloat(Roomgrid.GRIDSNAP)), Int((gm.currentScene?.size.height)! / CGFloat(Roomgrid.GRIDSNAP)))
        
        
        player = gm.currentScene?.childNode(withName: "player") as? WorldPlayer
        
        isActivated = true
        
        
        player.PlaceOntoGrid()
    }
}
