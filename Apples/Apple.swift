//
//  Apple.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class Apple: SKSpriteNode {
    
    private let AppleWidthPercent = CGFloat(0.025)
    private let AppleHeightPercent = CGFloat(0.025)
    private let AppleSpeed = CGFloat(5.0)
    private let AppleSize = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
    
    init(sceneSize: CGSize) {
        super.init(
            texture: SKTexture(imageNamed: "Apple"),
            color: nil,
            size: CGSizeMake(
                sceneSize.width * AppleWidthPercent,
                sceneSize.height * AppleHeightPercent * AppleSize.height
            )
        )
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0.5
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Apple
        self.physicsBody?.contactTestBitMask = CollisionCategory.Boy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMoving(velocityMultiplier: CGFloat) {
        self.physicsBody?.applyImpulse(CGVectorMake(0.0, velocityMultiplier * AppleSpeed * AppleSize.height))
    }
}
