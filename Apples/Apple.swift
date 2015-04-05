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
    var hit = false
    
    init(sceneSize: CGSize) {
        super.init(
            texture: SKTexture(imageNamed: "Apple"),
            color: nil,
            size: CGSizeMake(
                50,
                50
            )
        )
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Apple
        self.physicsBody?.contactTestBitMask = CollisionCategory.Virus
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drop(scene:SKScene) {
        
        let moveAction = SKAction.moveTo(
            CGPoint(x: CGFloat(arc4random_uniform(UInt32(scene.size.width))), y: -scene.size.height),
            duration: 1.5
        )
        
        self.runAction(moveAction, {
            self.resetPosition(scene)
        })
    }
    
    func resetPosition(scene:SKScene) {
        self.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(scene.size.width))), y: scene.size.height + (self.size.height * 2))
        self.hit = false
        println("Apple reset pos")
    }
}
