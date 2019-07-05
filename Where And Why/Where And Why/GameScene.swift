import SpriteKit
class GameScene: SKScene {
    
    let player = BattlerNode(imageNamed: "player_01")
    let enemy1 = BattlerNode(imageNamed: "monster_05")
    let enemy2 = BattlerNode(imageNamed: "monster_06")
    let enemy3 = BattlerNode(imageNamed: "monster_05")
    let enemy4 = BattlerNode(imageNamed: "monster_06")
    
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
        
        player.name = "player"
        player.position = CGPoint(x: 1700, y: 850)
        player.zPosition = 100
        player.size.width = player.size.width * 8
        player.size.height = player.size.height * 8
        addChild(player)
        
        enemy1.name = "enemy1"
        enemy1.position = CGPoint(x: 300, y: 820)
        enemy1.zPosition = 100
        enemy1.size.width = enemy1.size.width * 6
        enemy1.size.height = enemy1.size.height * 6
        addChild(enemy1)
        
        enemy2.name = "enemy2"
        enemy2.position = CGPoint(x: 540, y: 820)
        enemy2.zPosition = 100
        enemy2.size.width = enemy2.size.width * 6
        enemy2.size.height = enemy2.size.height * 6
        addChild(enemy2)
        
        enemy3.name = "enemy3"
        enemy3.position = CGPoint(x: 300, y: 980)
        enemy3.zPosition = 100
        enemy3.size.width = enemy3.size.width * 6
        enemy3.size.height = enemy3.size.height * 6
        addChild(enemy3)
        
        enemy4.name = "enemy4"
        enemy4.position = CGPoint(x: 540, y: 980)
        enemy4.zPosition = 100
        enemy4.size.width = enemy4.size.width * 6
        enemy4.size.height = enemy4.size.height * 6
        addChild(enemy4)
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
