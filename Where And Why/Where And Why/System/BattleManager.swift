//
//  BattleManager.swift
//  Where And Why
//
//  Created by Khori Armstrong on 2019-06-25.
//  Copyright © 2019 Sigh. All rights reserved.
//

import Foundation
import SpriteKit




enum Actions {
    case None
    case Fight
    case Skills
    case Items
    case Run
}

enum BattleStates {
    
    case Init
    
    // We choose enemy elements, we decide the background, we play the music, etc...
    case Start
    
    // Screen fades FROM black, enemies run in, player runs in, etc...
    case Intro
    
    
    // *** This is when you can tap on the screen to select actions and such.
    case PlayerTurn
    // *** This "displays" and executes on the actions you chose
    case PlayerAct
    // *** The game calculates the actions of each enemy
    case EnemyTurn
    // *** The game performs each action one by one.
    case EnemyAct
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
    var canTargetEnemies: Bool = false
    
    
    
    
    init() {
        encounterID = .Nothing
        
        
        
        
        // ??? <-- Placeholder code. Need the real stuff...
        let someView: SKView? = SKView()
        actionsView = someView
        skillsView = someView
        itemsView = someView
        messageView = someView
        statusView = someView
        
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
        
        
        print("Message: {" + self.battleMessage + "}")
    }
    
    
    
    
    
    var selectAction: Actions = .None
    var selectBattler: BattlerNode! = nil
    var selectSkill: Database.Skills = .None
    var selectItem: Database.ItemTypes = .None
    
    func Interaction(action: Actions) {
        if (selectState == .Actions) {
            selectAction = action
            
            switch action {
            case .None:
                changeBattleState(.PlayerAct)
                break
            case .Fight:
                changeSelectState(.Enemies)
                break
            case .Skills:
                changeSelectState(.Skills)
                break
            case .Items:
                changeSelectState(.Items)
                break
            case .Run:
                changeBattleState(.PlayerAct)
                break
            }
        }
        else {
            changeSelectState(.Actions)
        }
    }
    func Interaction(skill: Database.Skills) {
        selectSkill = skill
        //
        changeSelectState(.Enemies)
    }
    func Interaction(item: Database.ItemTypes) {
        selectItem = item
        //
        let thisItem: ItemData = Database.Instance().allItems[selectItem]!
        if (false) { // thisItem.effectType == .Attack
            changeSelectState(.Enemies)
        }
        else {
            changeBattleState(.PlayerAct)
        }
    }
    func Interaction(target: BattlerNode) {
        selectBattler = target
        //
        changeBattleState(.PlayerAct)
    }
    
    
    func PerformAction(who: BattlerNode, action: Actions, target: BattlerNode! = nil, skill: Database.Skills = .None, item: Database.ItemTypes = .None) {
        switch action {
        case .None:
            break
        case .Fight:
            if (target != nil) {
                who.Attack(who: target)
            }
            break
        case .Skills:
            if (target != nil) {
                who.Attack(who: target)
            }
            break
        case .Items:
            if (selectBattler == nil) {
                selectBattler = player
            }
            //
            selectBattler.UseItem(which: item)
            break
        case .Run:
            // ??? <-- Unimplemented... Eh?? What do we do?!?!
            EndBattle()
            break
        }
        //
        //
        // changeBattleState(.EnemyTurn)
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
            
            
            // ??? <-- Placeholder code!
            if (Inputter.wasTapped) {
                changeSelectState(.None)
                
                changeBattleState(.PlayerAct)
            }
            break
        case .PlayerAct:
            // ??? <-- Animate this or something...
            
            if (CGFloat(phaseTime) > SEC) {
                
                print("Attacking!")
                // ??? <-- DEBUGGING!!!
                for enemy in enemiesList {
                    player.Attack(who: enemy)
                }
                
                changeBattleState(.EnemyTurn)
            }
            break
        case .EnemyTurn:
            // ??? <-- Pretend like the game is thinking...
            
            if (CGFloat(phaseTime) > SEC) {
                changeBattleState(.EnemyAct)
            }
            break
        case .EnemyAct:
            // ??? <-- Animate this or something...
            
            
            
            
            if (CGFloat(phaseTime) > SEC) {
                
                // ??? <-- DEBUGGING!!!
                for enemy in enemiesList {
                    if (!enemy.isDead) {
                        enemy.Attack(who: player)
                    }
                }
                
                changeBattleState(.CheckWinLose)
            }
            break
            
        case .CheckWinLose:
            var test: Bool
            
            // *** If the hero is dead, winning doesn't matter.
            if (player.isDead) {
                changeBattleState(.Lose)
                break
            }
            else {
                
                // *** Assume all enemies are dead. If I'm wrong, then start the next turn
                test = true
                for enemy in enemiesList {
                    if (!enemy.isDead) {
                        test = false
                    }
                }
                
                if (test) {
                    changeBattleState(.Win)
                    break
                }
                else {
                    changeBattleState(.PlayerTurn)
                }
            }
            break
            
            
        case .Win:
            // ??? <-- Animate this or something...
            
            if (CGFloat(phaseTime) > SEC) {
                changeBattleState(.Rewards)
            }
            break
        case .Lose:
            
            break
            
            
        case .Rewards:
            // ??? <-- Animate this or something...
            
            if (CGFloat(phaseTime) > SEC*5) {
                changeBattleState(.Outro)
            }
            break
            
            
        case .Outro:
            // ??? <-- Animate this or something...
            
            if (CGFloat(phaseTime) > SEC*3) {
                changeBattleState(.End)
            }
            break
            
            
        case .End:
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
            //
            if (player == nil) {
                player = BattlerNode(imageNamed: "player")
            }
            //
            player.Setup(what: gm.playerData!)
            
            
            print("BattleManager: Sharpening the monsters' fangs...")
            // *** Prepare the list of enemies and get THEM ready!
            enemiesList.removeAll()
            for enemyType in db.allEncounters[self.encounterID]! {
                var battler: BattlerNode? = gm.scene?.childNode(withName: "enemy\(1+enemiesList.count)") as? BattlerNode
                //
                if (battler == nil) {
                    battler = BattlerNode(imageNamed: "enemy\(1+enemiesList.count)")
                }
                //
                battler?.Setup(what: enemyType)
                //
                enemiesList.append(battler!)
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
            Message(message: "Player's Turn", period: Helper.SECOND * 2)
            
            changeSelectState(.Actions)
            break
        case .PlayerAct:
            PerformAction(who: player, action: selectAction, target: selectBattler, skill: selectSkill, item: selectItem)
            break
        case .EnemyTurn:
            Message(message: "Enemies' Turns", period: Helper.SECOND * 2)
            break
        case .EnemyAct:
            break
            
        case .CheckWinLose:
            
            print("\(player.battleName) HP: \(player.HP)/\(player.MaxHP)")
            
            for enemy in enemiesList {
                print("\(enemy.battleName) HP: \(enemy.HP)/\(enemy.MaxHP)")
            }
            break
        case .Win:
            Message(message: "Victory!", period: Helper.SECOND * 2)
            break
        case .Lose:
            Message(message: "Defeated...", period: Helper.SECOND * 2)
            break
        case .Rewards:
            Message(message: "Gained X EXP!", period: Helper.SECOND * 2)
            Message(message: "Earned X Gold!", period: Helper.SECOND * 2)
            Message(message: "Found X!", period: Helper.SECOND * 2)
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
            // *** Initialize our selections
            selectAction = .None
            selectBattler = nil
            selectSkill = .None
            selectItem = .None
            
            actionsView.isHidden = true
            skillsView.isHidden = true
            itemsView.isHidden = true
            messageView.isHidden = true
            statusView.isHidden = false
            canTargetEnemies = false
            break
        case .Actions:
            // *** Reset our selections
            selectAction = .None
            selectBattler = nil
            selectSkill = .None
            selectItem = .None
            
            actionsView.isHidden = false
            skillsView.isHidden = true
            itemsView.isHidden = true
            messageView.isHidden = true
            statusView.isHidden = false
            canTargetEnemies = false
            break
        case .Enemies:
            actionsView.isHidden = true
            skillsView.isHidden = true
            itemsView.isHidden = true
            messageView.isHidden = true
            statusView.isHidden = true
            canTargetEnemies = true
            break
        case .Skills:
            actionsView.isHidden = true
            skillsView.isHidden = false
            itemsView.isHidden = true
            messageView.isHidden = true
            statusView.isHidden = true
            canTargetEnemies = false
            break
        case .Items:
            actionsView.isHidden = true
            skillsView.isHidden = true
            itemsView.isHidden = false
            messageView.isHidden = true
            statusView.isHidden = true
            canTargetEnemies = false
            break
            
        default:
            break
        }
    }
    // ---------------------------------------------------------
    
    
}


