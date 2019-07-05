//
//  Database.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



class Database {
    
    // *** Singleton Stuff.
    private static let _instance = Database()
    private init() {
        Initialize()
    }
    static func Instance() -> Database {
        return _instance
    }
    
    enum ItemTypes {
        case None
        
        // *** Consumables
        case Potion
        case HiPotion
        case MaxPotion
        
        case Panacea
        
        // *** Weapons
        case Barehands
        case WaterSword
        case WindSpear
        case FireAxe
    }
    enum ItemUsageTypes {
        case None
        case Consumable
        case Weapon
    }
    enum ItemEffectTypes {
        case None // *** Does nothing (and can't be selected)
        case Healing // *** Positively affects HP
        case Cure
        case Equip // *** Becomes your weapon when used
    }
    
    enum Ailments: Int {
        case None = 0
        
        case Bleeding = 1
        case Paralysis = 2
    }
    
    enum Skills: Int {
        case None
        case Bash
        case Slash
        case Stab
        
        case FireStab
    }
    
    
    
    var heroData: PlayerData?
    var allEnemies: [EnemyTypes: EnemyData] = [:]
    var allItems: [ItemTypes: ItemData] = [:]
    //
    var allEncounters: [EncounterTypes: Array<EnemyTypes>] = [:]
    
    enum EnemyTypes {
        case None
        case Slime
        case Wolf
        case Ninja
        case DemonLord
    }
    enum EncounterTypes {
        case Nothing
        case OneSlime
        case TwoSlimes
        case FourSlimes
    }
    
    
    func Initialize() {
        
        
        
        // -------------------------------------------------------------------------------------------
        // *** Set up the game's items!
        
        var WT: ItemData
        
        WT = ItemData(name: "Potion")
        WT.itemDesc = "A healing drink. It restores 30HP."
        WT.itemType = .Potion
        WT.usageType = .Consumable
        WT.effectType = .Healing
        WT.value = 30
        allItems[WT.itemType] = WT
        
        WT = ItemData(name: "Hi-Potion")
        WT.itemDesc = "A stronger iteration on the potion. It restores 150HP."
        WT.itemType = .HiPotion
        WT.usageType = .Consumable
        WT.effectType = .Healing
        WT.value = 30
        allItems[WT.itemType] = WT
        
        WT = ItemData(name: "Max Potion")
        WT.itemDesc = "A powerful drink named for its potent healing effect. It restores 500HP."
        WT.itemType = .MaxPotion
        WT.usageType = .Consumable
        WT.effectType = .Healing
        WT.value = 30
        allItems[WT.itemType] = WT
        
        WT = ItemData(name: "Panacea")
        WT.itemDesc = "A tonic named for its ability to cure most ailments."
        WT.itemType = .Panacea
        WT.usageType = .Consumable
        WT.effectType = .Cure
        allItems[WT.itemType] = WT
        
        
        WT = ItemData(name: "Bare Hands")
        WT.itemDesc = "No weapon; only your hands"
        WT.element = .Light
        WT.skillList = [.Bash]
        WT.itemType = .Barehands
        WT.usageType = .Weapon
        WT.effectType = .Equip
        WT.important = true
        allItems[WT.itemType] = WT
        
        WT = ItemData(name: "Typhoon Sword")
        WT.itemDesc = "A sword blessed by water. It can create whirlpools."
        WT.element = .Water
        WT.skillList = [.Slash, .Stab]
        WT.itemType = .WaterSword
        WT.usageType = .Weapon
        WT.effectType = .Equip
        WT.important = true
        allItems[WT.itemType] = WT
        
        WT = ItemData(name: "Gale Spear")
        WT.itemDesc = "A spear blessed with wind. It can cause tornados."
        WT.element = .Wind
        WT.skillList = [.Stab]
        WT.itemType = .WindSpear
        WT.usageType = .Weapon
        WT.effectType = .Equip
        WT.important = true
        allItems[WT.itemType] = WT
        
        WT = ItemData(name: "Inferno Axe")
        WT.itemDesc = "An axe blessed by fire. It can start conflagrations."
        WT.element = .Fire
        WT.skillList = [.Bash, .Slash]
        WT.itemType = .FireAxe
        WT.usageType = .Weapon
        WT.effectType = .Equip
        WT.important = true
        allItems[WT.itemType] = WT
        
        
        
        // -------------------------------------------------------------------------------------------
        // *** Set up The Hero!
        
        heroData = PlayerData(name: "Hero")
        
        
        heroData?.LVL = 1
        heroData?.Equip(what: .WaterSword)
        //
        heroData?.BHP = 10
        heroData?.BATK = 5
        heroData?.BDEF = 5
        //
        heroData?.GHP = 5
        heroData?.GATK = 2
        heroData?.GDEF = 2
        //
        heroData?.CalculateStats()
        //
        // *** Give them some HP
        heroData?.HP = heroData!.MaxHP
        
        // -------------------------------------------------------------------------------------------
        // *** Set up individual enemy data!
        var enemy: EnemyData
        
        // *** The Slime
        enemy = EnemyData(name: "Slime")
        enemy.MaxHP = 10
        enemy.ATK = 1
        enemy.DEF = 1
        enemy.LVL = 1
        enemy.EXPValue = 10
        enemy.enemyID = .Slime
        allEnemies[enemy.enemyID] = enemy
        
        // *** The Wolf
        enemy = EnemyData(name: "Wolf")
        enemy.MaxHP = 10
        enemy.ATK = 20
        enemy.DEF = 8
        enemy.LVL = 10
        enemy.EXPValue = 10
        enemy.enemyID = .Wolf
        allEnemies[enemy.enemyID] = enemy
        
        // *** The Ninja
        enemy = EnemyData(name: "Ninja")
        enemy.MaxHP = 10
        enemy.ATK = 30
        enemy.DEF = 20
        enemy.LVL = 20
        enemy.EXPValue = 10
        enemy.enemyID = .Ninja
        allEnemies[enemy.enemyID] = enemy
        
        
        
        
        // -------------------------------------------------------------------------------------------
        // *** Set up the battle encounters. MUST be after enemy set up!
        var ET: EncounterTypes
        
        ET = .Nothing
        allEncounters[ET] = []
        
        ET = .OneSlime
        allEncounters[ET] = [.Slime]
        
        ET = .TwoSlimes
        allEncounters[ET] = [.Slime, .Slime]
        
        ET = .FourSlimes
        allEncounters[ET] = [.Slime, .Slime, .Slime, .Slime]
    }
}
