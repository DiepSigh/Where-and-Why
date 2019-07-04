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
    
    //DefaultView Button Positions
    lazy var X1 = (screenWidth - 300)
    lazy var X2 = (screenWidth - 160)
    lazy var Y1 = (screenHeight - 160)
    lazy var Y2 = (screenHeight - 80)
    //DefaultView Buttons
    lazy var btnRun = UIButton(frame: CGRect(x: X2, y: Y2, width: 100, height: 60))
    lazy var btnItems = UIButton(frame: CGRect(x: X1, y: Y2, width: 100, height: 60))
    lazy var btnSkills = UIButton(frame: CGRect(x: X2, y: Y1, width: 100, height: 60))
    lazy var btnAttack = UIButton(frame: CGRect(x: X1, y: Y1, width: 100, height: 60))
    
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
        
        //Set up scene
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        //Text Display at top
        textDisplay.center = CGPoint(x: screenWidth/2, y: 40)
        textDisplay.textAlignment = .center
        textDisplay.text = ""
        textDisplay.backgroundColor = .white
        self.view.addSubview(textDisplay)
        
        //DEFAULT VIEW
        let defaultView = SKView()
        self.view.addSubview(defaultView)
        btnAttack.backgroundColor = .black
        btnAttack.setTitle("Attack", for: .normal)
        //Function to execute when pressed
        //btnAttack.addTarget(self, action: #selector(btnActionAtk), for: .touchUpInside)

        btnSkills.backgroundColor = .black
        btnSkills.setTitle("Skills", for: .normal)
        //btnSkills.addTarget(self, action: #selector(btnActionSkills), for: .touchUpInside)
        
        btnItems.backgroundColor = .black
        btnItems.setTitle("Items", for: .normal)
        //btnItems.addTarget(self, action: #selector(btnActionItems), for: .touchUpInside)
        
        btnRun.backgroundColor = .black
        btnRun.setTitle("Run", for: .normal)
        //btnRun.addTarget(self, action: #selector(btnActionRun), for: .touchUpInside)

        //Add buttons to view
        defaultView.isHidden = false
        defaultView.addSubview(btnAttack)
        defaultView.addSubview(btnSkills)
        defaultView.addSubview(btnItems)
        defaultView.addSubview(btnRun)
        
        //SKILLS VIEW
        let skillsView = SKView()
        self.view.addSubview(skillsView)
        
        for _ in 0...6 {
            let btn = UIButton()
            button.append(btn)
        }
        
        //Buttons
        var temp = 1
        for i in 1...6 {
            if i <= 3 {
                button[i].frame = CGRect(x: (i*90)-50, y: Int(Y1), width: 60,height: 60)
            }else{
                button[i].frame = CGRect(x: (temp*90)-50, y: Int(Y2), width: 60,height: 60)
                temp+=1
            }
            button[i].backgroundColor = .black
            button[i].setTitle("Test", for: .normal)
            skillsView.addSubview(button[i])
        }
        skillsView.isHidden = false
        
        //STATS VIEW
        //let statsView = SKView()
        
        statsDisplay.center = CGPoint(x: screenWidth/2, y: screenHeight - 180)
        statsDisplay.textAlignment = .left
        //Get HP
        statsDisplay.text = " Player HP: 5"
        statsDisplay.backgroundColor = .white
        //statsView.addSubview(statsDisplay)
        self.view.addSubview(statsDisplay)
        //statsView.isHidden = false
        
        //Number of enemies
        for _ in 0...4 {
            let lbl = UILabel()
            label.append(lbl)
        }
        
        for i in 1...4 {
            label[i].frame = CGRect(x: 0, y: 0, width: 200, height:40)
            label[i].center = CGPoint(x: screenWidth/2, y: screenHeight - (135))
            label[i].textAlignment = .left
            label[i].backgroundColor = .white
            //Get Slime HP
            label[i].text = " Slime HP: 5"
            self.view.addSubview(label[i])
        }
        
        // *** Get View ids
        gm.currentScene = scene
        
        bm.textBar = textDisplay
        bm.actionsView = skillsView
    }
    
}
