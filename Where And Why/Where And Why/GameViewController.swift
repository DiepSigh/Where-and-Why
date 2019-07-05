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
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    
    //Bottom Left Button Array
    //lazy var button: Array<UIButton> = []
    lazy var button = [UIButton]()
    
    //Enemy Stats Array
    lazy var label = [UILabel]()
    
    //Top Text Display
    lazy var textDisplay = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 40))
    //Stats Display Bottom
    lazy var statsDisplay = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gm = GameManager()
        gm.Initialize()
        //
        let bm: BattleManager = gm.battleMngr
        
        
        
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
        
        
        //DefaultView Button Positions
        let X1 = 0
        let X2 = 140
        let Y1 = 0
        let Y2 = 80
        //DefaultView Buttons
        var btnRun = UIButton(frame: CGRect(x: X2, y: Y2, width: 100, height: 60))
        var btnItems = UIButton(frame: CGRect(x: X1, y: Y2, width: 100, height: 60))
        var btnSkills = UIButton(frame: CGRect(x: X2, y: Y1, width: 100, height: 60))
        var btnAttack = UIButton(frame: CGRect(x: X1, y: Y1, width: 100, height: 60))
        
        
        
        let gameView = self.view as! SKView
        let messageView = BattleView()
        let statusView = BattleView()
        let defaultView = BattleView(frame: CGRect(x: screenWidth - 300, y: screenHeight - 160, width: 140+100, height: 80+60))
        let skillsView = BattleView()
        //
        gameView.addSubview(messageView)
        gameView.addSubview(statusView)
        gameView.addSubview(skillsView)
        gameView.addSubview(defaultView)
        //
        messageView.addSubview(textDisplay)
        //
        defaultView.backgroundColor = UIColor.red
        defaultView.addSubview(btnAttack)
        defaultView.addSubview(btnSkills)
        defaultView.addSubview(btnItems)
        defaultView.addSubview(btnRun)
        //
        for _ in 0...5 {
            let btn = UIButton()
            button.append(btn)
            //
            skillsView.addSubview(btn)
        }
        //
        statusView.addSubview(statsDisplay)
        for _ in 0...3 {
            let lbl = UILabel()
            label.append(lbl)
            //
            statusView.addSubview(lbl)
        }
        
        
        
        
        statsDisplay.center = CGPoint(x: screenWidth/2, y: screenHeight - 180)
        statsDisplay.textAlignment = .left
        //Get HP
        statsDisplay.text = " Player HP: 5"
        statsDisplay.backgroundColor = .white
        
        
        //Text Display at top
        textDisplay.center = CGPoint(x: screenWidth/2, y: 40)
        textDisplay.textAlignment = .center
        textDisplay.text = ""
        textDisplay.backgroundColor = .white
        
        //Buttons
        var temp = 1
        for i in 0...button.count-1 {
            if i <= 3 {
                button[i].frame = CGRect(x: (i*90)-50, y: Int(Y1), width: 60,height: 60)
            }else{
                button[i].frame = CGRect(x: (temp*90)-50, y: Int(Y2), width: 60,height: 60)
                temp+=1
            }
            button[i].backgroundColor = .black
            button[i].setTitle("Test", for: .normal)
        }
        skillsView.isHidden = false
        
        
        // Labels
        for i in 0...label.count-1 {
            label[i].frame = CGRect(x: 0, y: 0, width: 200, height:40)
            label[i].center = CGPoint(x: screenWidth/2, y: screenHeight - (135))
            label[i].textAlignment = .left
            label[i].backgroundColor = .white
            //Get Slime HP
            label[i].text = " Slime HP: 5"
        }
        
        //Set up scene
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        scene.scaleMode = .aspectFill
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        // skView.ignoresSiblingOrder = true
        //
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
        /*
        bm.actionsView = defaultView
        bm.skillsView = skillsView
 */
    }
    
    @objc func btnActionAtk(sender: UIButton!) {
        print("Pressed Attack")
        let gm = GameManager.Instance()
        gm.battleMngr.Interaction(action: .Fight)
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
    
}
