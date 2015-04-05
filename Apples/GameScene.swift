//
//  GameScene.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//

import SpriteKit

struct CollisionCategory {
    static let Boy : UInt32 = 1
    static let Virus : UInt32 = 1 << 1
    static let Apple : UInt32 = 1 << 2
    static let Wall : UInt32 = 1 << 3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var healthLabel:SKLabelNode! = nil
    private var boy:Boy! = nil
    private var health = 100
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.brownColor()
        
        var velocityMultiplier = self.size.width / self.size.height
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.friction = 0.0
        self.physicsBody?.categoryBitMask = CollisionCategory.Wall
        self.physicsBody?.contactTestBitMask = CollisionCategory.Boy
        
        createHealthLabel()
        
        boy = Boy(sceneSize: size)
        
        boy.position = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMaxY(self.frame) - 50)
        println(boy.size)
        self.addChild(boy)
    }
    
    func createHealthLabel() {
        healthLabel = SKLabelNode(fontNamed:"Chalkduster")
        healthLabel.text = "Health: \(health)";
        healthLabel.fontSize = 16;
        healthLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 50, y:CGRectGetMaxY(self.frame) - 50)
        self.addChild(healthLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            //            let sprite = SKSpriteNode(imageNamed:"Boy")
            //
            //            sprite.xScale = 0.5
            //            sprite.yScale = 0.5
            //            sprite.position = location
            //
            //            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            //
            //            sprite.runAction(SKAction.repeatActionForever(action))
            //
            //            self.addChild(sprite)
            
            boy.teleport(location, scene: self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
