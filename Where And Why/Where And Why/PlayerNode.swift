//
//  PlayerNode.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



class ActorNode: SKNode {
    var MaxHP = 0
    var HP = 0
    
    var ATK = 0
    var DEF = 0
    var LVL = 0
}

class EnemyNode: ActorNode {
    var EXPValue = 0
    var GoldValue = 0
    
    var ItemTheyDrop = 0
    var ItemDropChance = 100
}

class PlayerNode: ActorNode {
    var EXP = 0
}
