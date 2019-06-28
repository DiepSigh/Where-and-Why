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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up scene
        let scene = GameScene(size:CGSize(width: 2048, height: 1536))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        //Button Positions
        let X1 = (screenWidth - 320)
        let X2 = (screenWidth - 180)
        let Y1 = (screenHeight - 140)
        let Y2 = (screenHeight - 80)
        
        //Add buttons
        let btnAttack = UIButton(frame: CGRect(x: X1, y: Y1, width: 100, height: 50))
        btnAttack.backgroundColor = .black
        btnAttack.setTitle("Attack", for: .normal)
        btnAttack.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        let btnSkills = UIButton(frame: CGRect(x: X2, y: Y1, width: 100, height: 50))
        btnSkills.backgroundColor = .black
        btnSkills.setTitle("Skills", for: .normal)
        
        let btnItems = UIButton(frame: CGRect(x: X1, y: Y2, width: 100, height: 50))
        btnItems.backgroundColor = .black
        btnItems.setTitle("Items", for: .normal)
        
        let btnRun = UIButton(frame: CGRect(x: X2, y: Y2, width: 100, height: 50))
        btnRun.backgroundColor = .black
        btnRun.setTitle("Run", for: .normal)
        
        //Add buttons to scene?
        self.view.addSubview(btnAttack)
        self.view.addSubview(btnSkills)
        self.view.addSubview(btnItems)
        self.view.addSubview(btnRun)
    }

    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }

}
