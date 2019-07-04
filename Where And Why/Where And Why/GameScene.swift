import SpriteKit
class GameScene: SKScene {
    
    
    func transitionToScene(level: String) {
        guard let newScene = SKScene(fileNamed: level) as? GameScene else {
            fatalError("Level: {\(level)} not found")
        }
        
        
        view?.presentScene(newScene, transition: SKTransition.flipVertical(withDuration: 0.5))
    }
    
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        /*
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        */
        
        // GameManager.Instance().scene = self
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        Inputter.TapStart(touch)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        Inputter.TapMove(touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        
        Inputter.TapEnd(touch)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        GameManager.Instance().doUpdate(currentTime)
        //
        // *** This is LAST because of the nature of reading taps
        Inputter.Update()
    }
}
