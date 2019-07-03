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
    
    //Button Positions
    lazy var X1 = (screenWidth - 320)
    lazy var X2 = (screenWidth - 160)
    lazy var Y1 = (screenHeight - 160)
    lazy var Y2 = (screenHeight - 80)
    
    lazy var btnRun = UIButton(frame: CGRect(x: X2, y: Y2, width: 100, height: 50))
    lazy var btnItems = UIButton(frame: CGRect(x: X1, y: Y2, width: 100, height: 50))
    lazy var btnSkills = UIButton(frame: CGRect(x: X2, y: Y1, width: 100, height: 50))
    lazy var btnAttack = UIButton(frame: CGRect(x: X1, y: Y1, width: 100, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var gm = GameManager()
        gm.Initialize()
        
        
        
        //Set up scene
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        let skillsView = SKView()
        self.view.addSubview(skillsView)
        //Add buttons
        btnAttack.backgroundColor = .black
        btnAttack.setTitle("Attack", for: .normal)
        btnAttack.addTarget(self, action: #selector(btnActionAtk), for: .touchUpInside)

        btnSkills.backgroundColor = .black
        btnSkills.setTitle("Skills", for: .normal)
        btnSkills.addTarget(self, action: #selector(btnActionSkills), for: .touchUpInside)
        
        btnItems.backgroundColor = .black
        btnItems.setTitle("Items", for: .normal)
        btnItems.addTarget(self, action: #selector(btnActionItems), for: .touchUpInside)
        
        btnRun.backgroundColor = .black
        btnRun.setTitle("Run", for: .normal)
        btnRun.addTarget(self, action: #selector(btnActionRun), for: .touchUpInside)
        
        //Add buttons to scene?
//        self.view.addSubview(btnAttack)
//        self.view.addSubview(btnSkills)
//        self.view.addSubview(btnItems)
//        self.view.addSubview(btnRun)
        
        //skills, items, stats hp, enemy, text
        //makea view for each
        
        skillsView.isHidden = false
        skillsView.addSubview(btnAttack)
        skillsView.addSubview(btnSkills)
        skillsView.addSubview(btnItems)
        skillsView.addSubview(btnRun)
        //Hide Buttons
        //HideMainButtons()
    }

    @objc func btnActionAtk(sender: UIButton!) {
        print("Pressed")
    }
    
    @objc func btnActionSkills(sender: UIButton!) {
        print("Pressed")
    }
    
    @objc func btnActionItems(sender: UIButton!) {
        print("Pressed")
    }
    
    @objc func btnActionRun(sender: UIButton!) {
        print("Pressed")
    }
    
    func HideMainButtons(){
        btnAttack.isHidden = true
        btnSkills.isHidden = true
        btnItems.isHidden = true
        btnRun.isHidden = true
    }
    
    func ShowMainButtons(){
        btnAttack.isHidden = false
        btnSkills.isHidden = false
        btnItems.isHidden = false
        btnRun.isHidden = false
    }
    
}
