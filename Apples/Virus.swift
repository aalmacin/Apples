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
        var randomVirusImg = "Virus \(Int(arc4random_uniform(4)) + 1)"
        super.init(
        texture: SKTexture(imageNamed: randomVirusImg),
        color: nil,
        size: CGSizeMake(
            sceneSize.width * virusWidthPercent,
            sceneSize.height * virusHeightPercent * virusSize.height
            )
        )
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Virus
        self.physicsBody?.contactTestBitMask = CollisionCategory.Boy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving(velocityMultiplier: CGFloat) {
        self.physicsBody?.applyImpulse(CGVectorMake(0.0, velocityMultiplier * virusSpeed * virusSize.height))
    }
}
