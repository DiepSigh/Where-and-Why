//
//  Database.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



class Database: SKNode {
    enum Items: Int {
        case None = 0
        
        case Potion = 1
        case HiPotion = 2
        case MaxPotion = 3
        
        case Panacea = 4
        
    }
    
    enum Ailments: Int {
        case None = 0
        
        case Bleeding = 1
        case Paralysis = 2
    }
    
    enum Skills: Int {
        case Bash = 0
        case Slash = 1
        case Stab = 2
    }
    
    
    
    var allEnemies: Array<EnemyNode> = Array()
    
    func Initialize() {
        var enemy: EnemyNode
        
        // *** The Slime
        enemy = EnemyNode()
        enemy.MaxHP = 100
        enemy.ATK = 1
        enemy.DEF = 5
        enemy.LVL = 1
        enemy.EXPValue = 10
        allEnemies.append(enemy)
        
        // *** The Wolf
        enemy = EnemyNode()
        enemy.MaxHP = 100
        enemy.ATK = 20
        enemy.DEF = 8
        enemy.LVL = 10
        enemy.EXPValue = 10
        allEnemies.append(enemy)
        
        // *** The Ninja
        enemy = EnemyNode()
        enemy.MaxHP = 100
        enemy.ATK = 30
        enemy.DEF = 20
        enemy.LVL = 20
        enemy.EXPValue = 10
        allEnemies.append(enemy)
        
        
        
        
    }
}
