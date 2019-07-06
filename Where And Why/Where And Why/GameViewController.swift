//
//  GameViewController.swift
//  Where And Why
//
//  Created by Stephen Diep on 2019-06-25.
//  Copyright © 2019 DiepSigh. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    // ===========================================================================
    /*
     GameView ~ everything on screen
     StatusView
     PlayerHPBar
     Enemy1HPBar
     Enemy2HPBar
     Enemy3HPBar
     Enemy4HPBar
     ActionsView
     fightButton
     skillButton
     itemButton
     runButton
     SkillsView
     
     */
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    //Bottom Left Button Array
    //Skills
    lazy var button = [UIButton]()
    //Items
    lazy var button2 = [UIButton]()
    
    //Enemy Stats Array
    lazy var label = [UILabel]()
    
    //Top Text Display
    lazy var textDisplay = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 40))
    //Stats Display Bottom
    lazy var statsDisplay = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gm = GameManager()
        gm.Initialize()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "World_Test") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit // .resizeFill
                
                // Present the scene
                view.presentScene(scene)
                
                gm.currentScene = scene
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            
            gm.worldMngr.Room_Start()
            return
        }
        
        
        //
        let bm: BattleManager = gm.battleMngr
    
        //DefaultView Button Positions
        let X1 = 0
        let X2 = 140
        let Y1 = 0
        let Y2 = 80
        //DefaultView Buttons
        let btnRun = UIButton(frame: CGRect(x: X2, y: Y2, width: 100, height: 60))
        let btnItems = UIButton(frame: CGRect(x: X1, y: Y2, width: 100, height: 60))
        let btnSkills = UIButton(frame: CGRect(x: X2, y: Y1, width: 100, height: 60))
        let btnAttack = UIButton(frame: CGRect(x: X1, y: Y1, width: 100, height: 60))
        
        let gameView = self.view as! SKView
        let messageView = BattleView()
        let statusView = BattleView()
//      defaultView.frame = CGRect(x:0,y:0, width:self.view.frame.size.width,                 height:self.view.frame.size.height)
        let defaultView = BattleView(frame: CGRect(x: screenWidth - 300, y: screenHeight - 160, width: 140+100, height: 80+60))
        let skillsView = BattleView(frame: CGRect(x: 40, y: screenHeight - 160, width: 240, height: 140))
        let itemsView = BattleView(frame: CGRect(x: 40, y: screenHeight - 160, width: 240, height: 140))
        //
        gameView.addSubview(messageView)
        gameView.addSubview(statusView)
        gameView.addSubview(defaultView)
        gameView.addSubview(skillsView)
        gameView.addSubview(itemsView)
        //
        messageView.addSubview(textDisplay)
        //
        defaultView.addSubview(btnAttack)
        defaultView.addSubview(btnSkills)
        defaultView.addSubview(btnItems)
        defaultView.addSubview(btnRun)
        //Skills
        for _ in 0...5 {
            let btn = UIButton()
            button.append(btn)
            //
            skillsView.addSubview(btn)
        }
        //Items
        for _ in 0...5 {
            let btn = UIButton()
            button2.append(btn)
            //
            itemsView.addSubview(btn)
        }
        statusView.addSubview(statsDisplay)
        for _ in 0...3 {
            let lbl = UILabel()
            label.append(lbl)
            //
            statusView.addSubview(lbl)
        }
        //let test = GameManager.Instance()
        statsDisplay.center = CGPoint(x: screenWidth/2, y: screenHeight - 180)
        statsDisplay.textAlignment = .left
        //Get HP
        statsDisplay.text = " Player HP: "
        statsDisplay.backgroundColor = .white
        
        //Text Display at top
        textDisplay.center = CGPoint(x: screenWidth/2, y: 40)
        textDisplay.textAlignment = .center
        textDisplay.text = ""
        textDisplay.backgroundColor = .white
        
        //Buttons Bottom Left Skills
        var temp = 1
        for i in 0...button.count-1 {
            if i < 3 {
                button[i].frame = CGRect(x: ((i+1)*90)-50, y: Int(Y1), width: 60,height: 60)
            }else{
                button[i].frame = CGRect(x: (temp*90)-50, y: Int(Y2), width: 60,height: 60)
                temp+=1
            }
            button[i].backgroundColor = .black
            button[i].setTitle("-", for: .normal)
        }
        //skillsView.isHidden = true
        
        //Items
        temp = 1
        for i in 0...button2.count-1 {
            if i < 3 {
                button2[i].frame = CGRect(x: ((i+1)*90)-50, y: Int(Y1), width: 60,height: 60)
            }else{
                button2[i].frame = CGRect(x: (temp*90)-50, y: Int(Y2), width: 60,height: 60)
                temp+=1
            }
            button2[i].backgroundColor = .black
            button2[i].setTitle("o", for: .normal)
        }
        //itemsView.isHidden = false
        
        // Labels Middle
        for i in 0...label.count-1 {
            label[i].frame = CGRect(x: 0, y: 0, width: 200, height:20)
            label[i].center = CGPoint(x: screenWidth/2, y: screenHeight - (140)+(CGFloat(20*i)))
            label[i].textAlignment = .left
            label[i].backgroundColor = .white
            //Get Slime HP
            label[i].text = " - "
        }
        
        //Set up scene
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        scene.scaleMode = .aspectFill
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        // skView.ignoresSiblingOrder = true
        
        skView.presentScene(scene)
        
        //DEFAULT VIEW
        btnAttack.isUserInteractionEnabled = true
        btnAttack.backgroundColor = .black
        btnAttack.setTitle("Attack", for: .normal)
        btnAttack.addTarget(self, action: #selector(btnActionAtk), for: .touchUpInside)

        btnSkills.isUserInteractionEnabled = true
        btnSkills.backgroundColor = .black
        btnSkills.setTitle("Skills", for: .normal)
        btnSkills.addTarget(self, action: #selector(btnActionSkills), for: .touchUpInside)
        
        btnItems.isUserInteractionEnabled = true
        btnItems.backgroundColor = .black
        btnItems.setTitle("Items", for: .normal)
        btnItems.addTarget(self, action: #selector(btnActionItems), for: .touchUpInside)
        
        btnRun.isUserInteractionEnabled = true
        btnRun.backgroundColor = .black
        btnRun.setTitle("Run", for: .normal)
        btnRun.addTarget(self, action: #selector(btnActionRun), for: .touchUpInside)

        // *** Get View ids
        gm.currentScene = scene
        
        bm.textBar = textDisplay

        bm.actionsView = defaultView
        bm.skillsView = skillsView
        bm.itemsView = itemsView

        
        bm.controller = self
    }
    
    @objc func btnActionAtk(sender: UIButton!) {
        print("Pressed Attack")
        let gm = GameManager.Instance()
        //gm.battleMngr.Interaction(action: .Fight)
        gm.battleMngr.changeBattleState(.PlayerAct)
    }
    
    @objc func btnActionSkills(sender: UIButton!) {
        print("Pressed Skills")
        let gm = GameManager.Instance()
        gm.battleMngr.Interaction(action: .Skills)
    }
    
    @objc func btnActionItems(sender: UIButton!) {
        print("Pressed Items")
        let gm = GameManager.Instance()
        gm.battleMngr.Interaction(action: .Items)
    }
    
    @objc func btnActionRun(sender: UIButton!) {
        print("Pressed Run")
        let gm = GameManager.Instance()
        gm.battleMngr.Interaction(action: .Run)
    }
    
    
    @objc func btnPressedSkill(sender: UIButton!) {
        // we'd check "sender" to find out what its "index" is
        
        // GameManager.Instance().battleMngr.Interaction(skill: Database.Skills.Slash)
    }
    
    func updateUI(){
        let gm = GameManager.Instance()
        let db = Database.Instance()
        //
        let bm = gm.battleMngr
        
        
        statsDisplay.text = " Player HP: " + String(gm.battleMngr.player.HP) + "/" + String(gm.battleMngr.player.MaxHP)
        //Get number of enemies and type of enemy
        for n in 0...gm.battleMngr.enemiesList.count-1 {
            let enemy = gm.battleMngr.enemiesList[n]
        label[n].text = " " + enemy.battleName + " HP: " + String(enemy.HP) + "/" + String(enemy.MaxHP)
        }
        
        let item: ItemData = db.allItems[bm!.player.weapon]!
        for n in 0...item.skillList.count-1 {
            button[n].setTitle("\(item.skillList[n])", for: .normal)
        }
    }
    
}
