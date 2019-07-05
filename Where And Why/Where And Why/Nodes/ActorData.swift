//
//  ActorNode.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-27.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



class ActorData {
    var characterName = ""
    
    var MaxHP = 0
    var HP = 0
    
    var ATK = 0
    var DEF = 0
    var LVL = 0
    
    
    required init(name: String) {
        self.characterName = name
    }
}
