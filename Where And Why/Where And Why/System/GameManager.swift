//
//  GameManager.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-27.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class GameManager: SKSpriteNode {
    
    var battleMngr: BattleManager!
    // var worldMngr: WorldManager
    
    
    // var scene: SKScene?
    
    
    var playerData: PlayerData?
    var inventory: Inventory?
    
    
    // *** Singleton Stuff.
    private static var _instance: GameManager?
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)
        
        
        print("GameManager: Created.")
        
        self.battleMngr = nil
        GameManager._instance = self
        //
        self.Initialize()
        
        
        print("GameManager: Initted.")
    }
    static func Instance() -> GameManager {
        return _instance!
    }
    
    
    
    func Initialize() {
        battleMngr = BattleManager()
        playerData = Database.Instance().heroData!
        
        inventory = Inventory()
        
        print("GameManager: Initialization complete!")
    }
    
    
    func doUpdate(_ currentTime: TimeInterval) {
        if (battleMngr.isActivated) {
            battleMngr.doUpdate(currentTime)
        }
        else {
            battleMngr.BeginBattle(encounter: .OneSlime)
        }
    }
    
    
    
    
    
    
    
    
    
    func StartUpANewGame() {
        inventory?.EmptyOut()
        //
        inventory?.AddItem(what: .Potion)
        inventory?.AddItem(what: .Potion)
        inventory?.AddItem(what: .Potion)
        inventory?.AddItem(what: .Panacea)
        inventory?.AddItem(what: .FireAxe)
        inventory?.AddItem(what: .WaterSword)
        inventory?.AddItem(what: .WindSpear)
    }
    
}
