//
//  Virus.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class Virus: DroppableItem {
    let DROP_SPEED = 3.0
    
    // The initialization method/Constructor for the Virus Object
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
        self.physicsBody?.categoryBitMask = CollisionCategory.Virus
        self.physicsBody?.contactTestBitMask = CollisionCategory.Boy
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
