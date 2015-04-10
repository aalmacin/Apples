//
//  Boy.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class Boy: SKSpriteNode {
    
    init(sceneSize: CGSize) {
        super.init(
            texture: SKTexture(imageNamed: "Boy"),
            color: nil,
            size: CGSizeMake(
                100,
                100
            )
        )
        
        // Create the physicsbody object based off the initial texture
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = CollisionCategory.Boy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Moves the boy to wherever the player touched on the screen.
    func move(point: CGPoint, scene:SKScene) {
        
        var pointX = point.x
        var pointY = point.y
        
        
        //
        // Makes sure that the boy doesn't go outside the screen
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
        //
        //
        
        // Create and Run the move action
        let moveAction = SKAction.moveTo(
            CGPoint(x: pointX, y: pointY),
            duration: 0.3
        )
        self.runAction(moveAction)
    }
}
