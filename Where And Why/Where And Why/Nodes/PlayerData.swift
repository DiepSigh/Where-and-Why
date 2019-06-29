//
//  PlayerNode.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class PlayerData: ActorData {
    var EXP = 0
    var nextEXP = 0
    
    var weapon: Database.ItemTypes = .Barehands
    
    
    
    
    // *** Base
    var BHP = 0
    var BATK = 0
    var BDEF = 0
    //
    // *** Growth
    var GHP = 0
    var GATK = 0
    var GDEF = 0
    
    
    
    
    func Equip(what: Database.ItemTypes) {
        self.weapon = what
        //
        // ??? <-- Check if you're equipping a WEAPON...
    }
    
    
    
    
    
    func LevelUp() {
        self.LVL += 1
        //
        self.EXP = 0
        self.nextEXP = 10 * self.LVL
        //
        CalculateStats()
    }
    
    func CalculateStats() {
        self.MaxHP = self.BHP + self.GHP * self.LVL
        self.ATK = self.BATK + self.GATK * self.LVL
        self.DEF = self.BDEF + self.GDEF * self.LVL
    }
}
