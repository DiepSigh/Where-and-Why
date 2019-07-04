//
//  WeaponData.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-27.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class ItemData {
    
    init(name: String) {
        self.itemName = name
    }
    
    var itemName = ""
    var itemDesc = ""
    var itemType: Database.ItemTypes = .Barehands
    var usageType: Database.ItemUsageTypes = .None
    var effectType: Database.ItemEffectTypes = .None
    
    var price: Int = 0
    // *** "Important" items can't be destroyed, stolen, dropped, or sold
    var important: Bool = false
    
    
    // *** Consumable parameters
    var value: Int = 0
    
    
    // *** Weapon parameters
    var element: Elements = .Light
    var skillList: Array<Database.Skills> = Array()
    
    
}
