//
//  Inventory.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-27.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit


class Inventory {
    
    
    var myItems: [Database.ItemTypes : Int] = [:]
    
    
    // *** Adds an item to your inventory
    func AddItem(what: Database.ItemTypes) {
        if (myItems[what] == nil) {
            myItems[what] = 1
        }
        else {
            myItems[what] = myItems[what]! + 1
        }
    }
    
    // *** Removes an item from your inventory
    func RemoveItem(what: Database.ItemTypes) -> Bool {
        if (myItems[what] == nil) {
            // *** Can't remove an item that doesn't exist
            return false
        }
        else if (myItems[what] == 0) {
            // *** Your quantity is currently 0
            // *** (Yes, this IS intentional! Once you've gotten an item, you will always know about it)
            return false
        }
        else {
            myItems[what] = myItems[what]! - 1
            return true
        }
    }
    
    
    func EmptyOut() {
        myItems = [:]
        
    }
    
    
    // *** Returns whether you have at least 1 of an item
    func HasItem(what: Database.ItemTypes) -> Bool {
        if (myItems[what] == nil) {
            return false
        }
        else if (myItems[what] == 0) {
            return false
        }
        else {
            return true
        }
    }
    
}
