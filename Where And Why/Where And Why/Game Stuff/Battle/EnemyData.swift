//
//  EnemyData.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-27.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class EnemyData: ActorData {
    var EXPValue = 0
    var GoldValue = 0
    
    var ItemTheyDrop = 0
    var ItemDropChance = 100
    
    
    var enemyID: Database.EnemyTypes = .None
}
