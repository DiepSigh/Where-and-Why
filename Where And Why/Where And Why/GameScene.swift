import SpriteKit
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        // GameManager.Instance().scene = self
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        GameManager.Instance().doUpdate(currentTime)
    }
    
}
