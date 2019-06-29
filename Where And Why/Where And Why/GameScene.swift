import SpriteKit
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
    }
    
    
}
