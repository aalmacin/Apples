//
//  DroppableItem.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-10.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class DroppableItem: SKSpriteNode {
    var hit = false
    var dropSpeed:NSTimeInterval = 0
    
    // Initialization method for the droppable item class
    init(sceneSize: CGSize, imageNamed: String, dropSpeed: NSTimeInterval) {
        
        // Call the parent's init function and passed the arguments needed
        super.init(
            texture: SKTexture(imageNamed: imageNamed),
            color: nil,
            size: CGSizeMake(
                50,
                50
            )
        )
        
        // Set the object's drop speed to the value of the dropSpeed parameter
        self.dropSpeed = dropSpeed
        
        // Create a physics body for the object
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        
        // We don't want the sprite to rotate so we set it's physics body rotation to false
        self.physicsBody?.allowsRotation = false
        
        // Call the set Bit Mask method
        setBitMask()
    }
    
    // I was deciding on making this a protocol instead but some objects in the future may need to only have the boy set as the test bit mask
    internal func setBitMask() {
        self.physicsBody?.contactTestBitMask = CollisionCategory.Boy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // The method used to drop the object from the top of the scene to the bottom of the screen
    func drop(scene:SKScene) {
        let moveAction = SKAction.moveTo(
            CGPoint(x: CGFloat(arc4random_uniform(UInt32(scene.size.width))), y: -scene.size.height),
            duration: dropSpeed
        )
        
        self.runAction(moveAction, {
            self.resetPosition(scene)
        })
    }
    
    func resetPosition(scene:SKScene) {
        self.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(scene.size.width))), y: scene.size.height + (self.size.height * 2))
        self.hit = false
        self.hidden = false
    }
}