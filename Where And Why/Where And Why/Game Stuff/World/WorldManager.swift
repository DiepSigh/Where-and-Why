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
        //
        rg.Reconstruct(Int((gm.currentScene?.size.width)! / CGFloat(Roomgrid.GRIDSNAP)), Int((gm.currentScene?.size.height)! / CGFloat(Roomgrid.GRIDSNAP)))
        
        
        player = gm.currentScene?.childNode(withName: "player") as? WorldPlayer
        
        isActivated = true
        
        
        player.PlaceOntoGrid()
    }
    
    
    
    func didStepTaken(_ who: WorldActor) {
        if who == player {
            if who.stepsTaken >= 40 {
                switch Int.random(in: 0...2) {
                case 0:
                    GameManager.Instance().battleMngr.BeginBattle(encounter: .OneSlime)
                case 1:
                    GameManager.Instance().battleMngr.BeginBattle(encounter: .TwoSlimes)
                case 2:
                    GameManager.Instance().battleMngr.BeginBattle(encounter: .FourSlimes)
                    break
                    
                default:
                    // *** Do nothing.
                    break
                }
            }
        }
    }
}
