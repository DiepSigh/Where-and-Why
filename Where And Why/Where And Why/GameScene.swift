import SpriteKit
class GameScene: SKScene {
    
    let player = SKSpriteNode(imageNamed: "player_01")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        let background = SKSpriteNode(imageNamed: "plains")
        let screenSize : CGRect = UIScreen.main.bounds
        background.size.width = screenSize.width * 3
        background.size.height = screenSize.height * 3
        //background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint.zero
        background.zPosition = -1
        addChild(background)
//        background.position = CGPoint.zero
        
        // GameManager.Instance().scene = self
        
        player.position = CGPoint(x: 1700, y: 800)
        player.zPosition = 100
        player.size.width = player.size.width * 8
        player.size.height = player.size.height * 8
        addChild(player)
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
