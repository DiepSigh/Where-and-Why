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



class BattlerNode: SKSpriteNode {
    
    var battleName = ""
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
    
    var weapon: Database.ItemTypes = .Barehands
    
    
    
    func Setup(what: Database.EnemyTypes) {
        let ed: EnemyData = Database.Instance().allEnemies[what]!
        
        
        self.battleName = ed.characterName
        //
        self.MaxHP = ed.MaxHP
        self.ATK = ed.ATK
        self.DEF = ed.DEF
        self.LVL = ed.LVL
        
        
        // *********************
        
        
        // *** Enemies start at max strength
        self.HP = self.MaxHP
        self.element = Elements(rawValue: Int.random(in: 0...2))! // *** Random number between 0 and 2
    }
    func Setup(what: PlayerData) {
        
        
        self.battleName = what.characterName
        //
        self.MaxHP = what.MaxHP
        self.ATK = what.ATK
        self.DEF = what.DEF
        self.LVL = what.LVL
        
        // *********************
        
        // *** The hero... Does not.
        self.HP = what.HP
        self.weapon = what.weapon
        //
        // *** Your element is whatever weapon you're holding!
        self.element = Database.Instance().allItems[self.weapon]!.element
    }
    
    
    
    func UseItem(which: Database.ItemTypes) {
        let db: Database = Database.Instance()
        //
        let item: ItemData = db.allItems[which]!
        //
        let useType: Database.ItemUsageTypes = item.usageType
        let effectType: Database.ItemEffectTypes = item.effectType
        
        
        switch effectType {
        case .Healing:
            self.heal(howMuch: item.value)
            break
        case .Cure:
            self.ailment = .None
            break
        case .Equip:
            EquipItem(which: which)
            break
            
        default:
            break
        }
        /*
        switch useType {
        case .Consumable:
            
            
            
            break
        case .Weapon:
            break
            
        default:
            break
        }
 */
    }
    
    
    func EquipItem(which: Database.ItemTypes) {
        self.weapon = which
    }
    
    
    
    
    
    func Attack(who: BattlerNode) {
        let bm = GameManager.Instance().battleMngr!
        
        print("\(self.battleName) attacks \(who.battleName)!")
        
        var damValue = 0
        damValue = Helper.Max(1, self.ATK - who.DEF)
        // *** Damage is always at least 1
        
        
        damValue = who.checkAttack(howMuch: damValue, whatElement: self.element)
        //
        if (damValue > 0) {
            print("\(who.battleName) receives \(damValue) damage!")
            who.takeHit(howMuch: damValue)
            
            bm.Message("\(self.battleName) hits \(who.battleName) for \(damValue) damage!")
        }
        else {
            print("\(who.battleName) dodges the attack!")
            // *** Dealing 0 damage is considered as "missing".
            // ??? <-- Display a "miss"...?
            
            bm.Message("\(self.battleName) misses \(who.battleName)!")
        }
    }
    
    
    
    func checkAttack(howMuch: Int, whatElement: Elements) -> Int {
        
        var calcValue: CGFloat = CGFloat(howMuch)
        
        // *** Fire = 0, Wind = 1, Water = 2. We can determine something's "strong" element by adding 1 to it, or its "weak" element by subtracting 1. Use Modular operator to "wrap around" if we go above 2 or below 0.
        if (Helper.ModWrap(self.element.rawValue+1,3) == whatElement.rawValue) {
            calcValue = calcValue * 0.7
            // *** Weak elements deal 30% less damage
        }
        else if (Helper.ModWrap(self.element.rawValue-1,3) == whatElement.rawValue) {
            calcValue = calcValue * 1.3
            // *** Strong elements deal 30% more damage
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
        HP = Helper.Min(HP + howMuch, MaxHP)
        //
        if (isDead && HP > 0) {
            isDead = false
        }
    }
    
    
}

