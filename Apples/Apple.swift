//
//  Apple.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class Apple: DroppableItem {
    let DROP_SPEED = 1.5
    // The initialization method/Constructor for the Apple Object
    init(sceneSize: CGSize, imageNamed: String) {
        // Call the parent class' init method. Set the Drop speed to the constant
        super.init(
            sceneSize: sceneSize,
            imageNamed: imageNamed,
            dropSpeed: DROP_SPEED
        )
    }
    
    // Override the setBitMask function from DroppableItem class
    override func setBitMask() {
        self.physicsBody?.categoryBitMask = CollisionCategory.Apple
        self.physicsBody?.contactTestBitMask = CollisionCategory.Boy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

