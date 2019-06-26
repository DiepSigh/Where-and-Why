//
//  BattleManager.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit



enum BattleStates {
    
    case Init
    
    // We choose enemy elements, we decide the background, we play the music, etc...
    case Start
    
    // Screen fades FROM black, enemies run in, player runs in, etc...
    case Intro
    
    
    // *** This is when you can tap on the screen to select actions and such.
    case PlayerTurn
    // *** The game automatically makes the enemies each perform an action.
    case EnemyTurn
    // *** We check if all enemies are dead or if the player is dead. Go to "Win" if enemies dead, go to "Lose" if player is dead.
    case CheckWinLose
    
    // *** Hero guy rejoices, fanfare plays
    case Win
    // *** Hero guy falls die, sad music plays
    case Lose
    
    // *** You see all the items you get, all the EXP you got
    case Rewards
    
    // *** Screen fades to black
    case Outro
    
    // *** We get ready to go back to "World" mode. Record current stats, send battle state to world state, ...
    case End
}

enum SelectStates {
    case None
    case Actions
    case Enemies
    case Skills
    case Items
}


class BattleManager: SKNode {
    
    
    // =========================================================
    var battleState: BattleStates = .Init {
        didSet {
            updateBattleState(from: oldValue, to: battleState)
        }
    }
    func changeState(state: BattleStates) {
        battleState = state
    }
    func updateBattleState(from: BattleStates, to: BattleStates) {
        switch to {
        case .Init:
            break
            
        case .Start:
            break
            
        case .Intro:
            break
            
        case .PlayerTurn:
            break
        case .EnemyTurn:
            break
            
        case .CheckWinLose:
            break
        case .Win:
            break
        case .Lose:
            break
        case .Rewards:
            break
        case .Outro:
            break
        case .End:
            break
            
            
        default:
            break
        }
    }
    // ---------------------------------------------------------
    
    
    
    // =========================================================
    var selectState: SelectStates = .None {
        didSet {
            updateSelectState(from: oldValue, to: selectState)
        }
    }
    func changeState(state: SelectStates) {
        selectState = state
    }
    func updateSelectState(from: SelectStates, to: SelectStates) {
        switch to {
        case .None:
            break
        case .Actions:
            // *** Player picks an action on the screen.
            /*
             * Fight ~ 
             */
            break
        case .Enemies:
            break
        case .Skills:
            break
        case .Items:
            break
            
        default:
            break
        }
    }
    // ---------------------------------------------------------
    
    
}


