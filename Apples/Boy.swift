//
//  Boy.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class Boy: SKSpriteNode {
    private let boySizePercent = CGFloat(0.15)
    private let boyWidthPercent = CGFloat(0.075)
    private let boyLengthPercent = CGFloat(0.15)
    private let boyLength:CGFloat
    
    init(sceneSize: CGSize) {
        boyLength = sceneSize.height * boyLengthPercent
        super.init(
            texture: SKTexture(imageNamed: "Boy"),
            color: nil,
            size: CGSizeMake(
                100,
                100
            )
        )
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(point: CGPoint, scene:SKScene) {
        
        var pointX = point.x
        var pointY = point.y
        
        if pointX > (scene.size.width - self.size.width) {
            pointX = scene.size.width - (self.size.width / 2)
        }
            
        if pointX < ( self.size.width) {
            pointX = (self.size.width / 2)
        }
        
        if pointY > (scene.size.height  - self.size.height) {
            pointY = scene.size.height  - (self.size.height / 2)
        }
            
        if pointY < self.size.height {
            pointY = (self.size.height / 2)
        }
        
        
        let moveAction = SKAction.moveTo(
            CGPoint(x: pointX, y: pointY),
            duration: 0.3
        )
        self.runAction(moveAction)
    }
}
