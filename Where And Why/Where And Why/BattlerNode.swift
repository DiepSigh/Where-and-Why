//
//  BattlerNode.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



enum Elements: Int {
    case Fire = 0
    case Wind = 1
    case Water = 2
    
    // *** These MUST be gapped!
    case Dark = 3
    case Light = 4
}



class BattlerNode: SKNode {
    
    var MaxHP = 0
    var HP = 0
    
    var ATK = 0
    var DEF = 0
    var LVL = 0
    
    var EXPValue = 0
    
    
    var isDead = false
    
    
    var element: Elements = .Light
    var ailment: Database.Ailments = .None
    var skills: Array<Database.Skills> = Array()
    
    
    
    func Setup(what: EnemyNode) {
        self.MaxHP = what.MaxHP
        self.ATK = what.ATK
        self.DEF = what.DEF
        self.LVL = what.LVL
        
        
        // *********************
        
        
        self.HP = self.MaxHP
        // self.element = Elements(Int.random(in: 0...2)) // *** Random number between 0 and 2
    }
    func Setup(what: PlayerNode) {
        self.MaxHP = what.MaxHP
        self.ATK = what.ATK
        self.DEF = what.DEF
        self.LVL = what.LVL
        
        // *********************
        
        
    }
    
    
    
    
    
    func Attack(who: BattlerNode) {
        var damValue = 0
        
        if (self.ATK >= who.DEF) {
            damValue = 1
        }
        else {
            damValue = self.ATK - who.DEF
        }
        // damValue = Max(1, self.ATK - who.DEF)
        
        
        damValue = who.checkAttack(howMuch: damValue, whatElement: self.element)
        //
        who.takeHit(howMuch: damValue)
    }
    
    
    
    func checkAttack(howMuch: Int, whatElement: Elements) -> Int {
        
        var calcValue: CGFloat = CGFloat(howMuch)
        
        if (self.element.rawValue+1 == whatElement.rawValue) {
            calcValue = calcValue * 0.7
        }
        else if (self.element.rawValue-1 == whatElement.rawValue) {
            calcValue = calcValue * 1.3
        }
        
        
        
        
        if (Int.random(in: 0...100) < 15) {
            // *** 15% chance of missing
            calcValue = 0
        }
        else if (Int.random(in: 0...100) < 15) {
            // *** 15% Chance of critical hit (double damage)
            calcValue = calcValue * 2
        }
        
        
        return Int(calcValue)
    }
    
    func takeHit(howMuch: Int) {
        HP -= howMuch
        //
        if (HP <= 0) {
            isDead = true
            
            // *** ... I dunno, do other cool stuff.
        }
    }
    
    
    func heal(howMuch: Int) {
        if (HP+howMuch >= MaxHP) {
            HP = MaxHP
        }
        else {
            HP += howMuch
        }
        // HP = Min(HP + howMuch, MaxHP)
        
        if (isDead && HP > 0) {
            isDead = false
        }
    }
    
    
}

