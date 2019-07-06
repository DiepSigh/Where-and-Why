import SpriteKit
class GameScene: SKScene {
    
    func transitionToScene(level: String) {
        let gm = GameManager.Instance()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: level) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit // .resizeFill
                
                gm.currentScene = scene as? GameScene
                
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
                view.showsPhysics = true
                
                view.presentScene(scene, transition: SKTransition.flipVertical(withDuration: 0.5))
            }
        }
        
        
        gm.currentScene?.prepareScene()
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }
    
    
    func prepareScene() {
        // OVERRIDE THIS!
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        Inputter.TapStart(touch)
        
        
        let positionInScene = touch.location(in: self)
        print(positionInScene)
        let touchedNode = self.atPoint(positionInScene) as? BattlerNode
        print(touchedNode)
        //
        if touchedNode != nil {
            touchedNode!.doTapped()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        Inputter.TapMove(touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        Inputter.TapEnd(touch)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        GameManager.Instance().doUpdate(currentTime)
        //
        // *** This is LAST because of the nature of reading taps
        Inputter.Update()
    }
}
