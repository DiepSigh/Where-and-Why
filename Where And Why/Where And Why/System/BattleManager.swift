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


class BattleManager {
    var isActivated: Bool = false
    
    var player: BattlerNode!
    var enemiesList: Array<BattlerNode> = Array()
    var encounterID: Database.EncounterTypes
    
    
    
    var actionsView: SKView!
    var skillsView: SKView!
    var itemsView: SKView!
    var messageView: SKView!
    var statusView: SKView!
    
    
    
    
    init() {
        encounterID = .Nothing
        
        
        print("BattleManager: Created and initted.")
    }
    
    
    func BeginBattle(encounter: Database.EncounterTypes) {
        print("BattleManager: Preparing a battle...")
        isActivated = true
        //
        //
        self.encounterID = encounter
        //
        //
        changeBattleState(.Init)
        changeSelectState(.None)
        //
        //
        print("BattleManager: ... Done. The battle is ready!")
    }
    func EndBattle() {
        isActivated = false
        //
        // ??? <-- Reactivate the WorldManager... Or kill the game...?
    }
    
    
    
    
    var battleMessage: String = ""
    var messageMoment: CGFloat = 0
    var messagePeriod: CGFloat = 0
    func Message() {
        self.messageMoment = CGFloat(phaseTime)
        //
        self.battleMessage = ""
        self.messagePeriod = 9999
    }
    func Message(message: String, period: CGFloat) {
        self.messageMoment = CGFloat(phaseTime)
        //
        self.battleMessage = message
        self.messagePeriod = period
    }
    
    
    
    
    
    func doUpdate(_ currentTime: TimeInterval) {
        // *** Initialize right away if its necessary-- Don't even wait.
        if (battleState == .Init) {
            print("BattleManager: Everything looks ready. Let's start!")
            
            changeBattleState(.Start)
            return
        }
    
        
    
        phaseTime += 1
        selectTime += 1
        //
        //
        // *** Erases the current battle message if its time is up
        if (CGFloat(phaseTime) >= messageMoment+messagePeriod) {
            Message()
        }
        
        // *** Handle the current battle phase...
        let t = CGFloat(phaseTime)
        let SEC = Helper.SECOND
        switch battleState {
        case .Intro:
            let fadeInAlpha = Helper.BlendTowards(t, SEC * 2, SEC)
            let actorFlyIn = Helper.BlendTowards(t, SEC * 2.5, SEC/3)
            
            var enemyRolecall: [CGFloat] = []
            for n in 0...enemiesList.count-1 {
                enemyRolecall.append(Helper.BlendTowards(t, SEC * 3 + SEC * CGFloat(n), SEC * 1))
            }
            
            
            
            
            if (enemyRolecall.last! >= CGFloat(1)) {
                changeBattleState(.PlayerTurn)
            }
            break
            
        case .PlayerTurn:
            // *** We let the menus handle this!
            break
            
        default:
            fatalError("Missing phase in BattleManager: \(battleState)")
        }
    }
    
    
    
    
    // =========================================================
    var phaseTime: Int = 0
    var battleState: BattleStates = .Init {
        didSet {
            print("BattleManager: *** Battle Phase ~ \(battleState) ***")
            phaseTime = 0
            //
            updateBattleState(from: oldValue, to: battleState)
        }
    }
    func changeBattleState(_ state: BattleStates) {
        self.battleState = state
    }
    func updateBattleState(from: BattleStates, to: BattleStates) {
        let db: Database = Database.Instance()
        let gm: GameManager = GameManager.Instance()
        
        switch to {
        case .Init:
            break
            
        case .Start:
            print("BattleManager: Gearing up the hero...")
            // *** Get the player battler ready!
            player = gm.scene?.childNode(withName: "player") as? BattlerNode
            player.Setup(what: gm.playerData!)
            
            
            print("BattleManager: Sharpening the monsters' fangs...")
            // *** Prepare the list of enemies and get THEM ready!
            enemiesList.removeAll()
            for enemyType in db.allEncounters[self.encounterID]! {
                let battler: BattlerNode? = gm.scene?.childNode(withName: "enemy\(1+enemiesList.count)") as? BattlerNode
                //
                if (battler != nil) {
                    battler?.Setup(what: enemyType)
                }
            }
            
            
            /* ??? <-- Get "correct" views
            actionsView = gm.scene?.view as? SKView
            skillsView = gm.scene?.view as? SKView
            itemsView = gm.scene?.view as? SKView
            messageView = gm.scene?.view as? SKView
            statusView = gm.scene?.view as? SKView
            */
            //
            //
            changeBattleState(.Intro)
            break
            
        case .Intro:
            break
            
        case .PlayerTurn:
            changeSelectState(.Actions)
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
            
            // ??? <-- Do stuff...
            //
            EndBattle()
            break
            
            
        default:
            break
        }
    }
    // ---------------------------------------------------------
    
    
    
    // =========================================================
    var selectTime: Int = 0
    var selectState: SelectStates = .None {
        didSet {
            selectTime = 0
            //
            updateSelectState(from: oldValue, to: selectState)
        }
    }
    func changeSelectState(_ state: SelectStates) {
        self.selectState = state
    }
    func updateSelectState(from: SelectStates, to: SelectStates) {
        switch to {
        case .None:
            
            break
        case .Actions:
            // *** Player picks an action on the screen.
            
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


