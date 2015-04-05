//
//  Virus.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class Virus: SKSpriteNode {
    
    private let virusWidthPercent = CGFloat(0.025)
    private let virusHeightPercent = CGFloat(0.025)
    private let virusSpeed = CGFloat(5.0)
    private let virusSize = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
    
    init(sceneSize: CGSize) {
        super.init(
        texture: SKTexture(imageNamed: Virus.randomVirusImg()),
        color: nil,
        size: CGSizeMake(
            50,
            50
            )
        )
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategory.Virus
        self.physicsBody?.contactTestBitMask = CollisionCategory.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func randomVirusImg() -> String {
        return "Virus\(Int(arc4random_uniform(4)) + 1)"
    }
    
    func resetTexture() {
        texture = SKTexture(imageNamed: Virus.randomVirusImg())
    }
    
    func startMoving(velocityMultiplier: CGFloat) {
        self.physicsBody?.applyImpulse(CGVectorMake(0.0, velocityMultiplier * virusSpeed * virusSize.height))
    }
    
    func drop(scene:SKScene) {
        
        let moveAction = SKAction.moveTo(
            CGPoint(x: CGFloat(arc4random_uniform(UInt32(scene.size.width))), y: -scene.size.height),
            duration: 3
        )
        
        self.runAction(moveAction, {
            self.resetPosition(scene)
        })
    }
    
    func resetPosition(scene:SKScene) {
        self.position.x = CGFloat(arc4random_uniform(UInt32(scene.size.width)))
        self.position.y = scene.size.height + (self.size.height * 2)
        self.resetTexture()
    }
}
