//
//  InstructionsScene.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class InstructionsScene: SKScene {
    // configure InstructionsScene
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor.brownColor()
        
        let instructionsHeaderLabel = SKLabelNode(fontNamed: "Futura-Medium")
        instructionsHeaderLabel.text = "Instructions"
        instructionsHeaderLabel.fontSize = 18
        instructionsHeaderLabel.fontColor = SKColor.whiteColor()
        instructionsHeaderLabel.position.x = size.width / 2.0
        instructionsHeaderLabel.position.y =
            size.height - 100 + instructionsHeaderLabel.fontSize
        self.addChild(instructionsHeaderLabel)
        
        
        let instructionsLabel1 = createInstructionsLabel("You will lose 10% health by getting hit by viruses.")
        instructionsLabel1.position.y = instructionsHeaderLabel.position.y - 50 + instructionsLabel1.fontSize
        self.addChild(instructionsLabel1)
        
        let instructionsLabel2 = createInstructionsLabel("You will gain 20% health when you get hit by an apple.")
        instructionsLabel2.position.y = instructionsLabel1.position.y - 50 + instructionsLabel2.fontSize
        self.addChild(instructionsLabel2)
        
        let instructionsLabel3 = createInstructionsLabel("Stay alive and gain points every second.")
        instructionsLabel3.position.y = instructionsLabel2.position.y - 50 + instructionsLabel3.fontSize
        self.addChild(instructionsLabel3)
        
        let instructionsLabel4 = createInstructionsLabel("When your health goes down to 0%, the game is over.")
        instructionsLabel4.position.y = instructionsLabel3.position.y - 50 + instructionsLabel4.fontSize
        self.addChild(instructionsLabel4)
        
        let goBackLabel = SKLabelNode(fontNamed: "Futura-Medium")
        goBackLabel.text = "Click anywhere to go back"
        goBackLabel.fontSize = 16
        goBackLabel.fontColor = SKColor.whiteColor()
        goBackLabel.position.x = size.width / 2.0
        goBackLabel.position.y =
            instructionsLabel4.position.y - 100 + instructionsHeaderLabel.fontSize
        self.addChild(goBackLabel)
    }
    
    private func createInstructionsLabel(text: String) -> SKLabelNode {
        let newLabel = SKLabelNode(fontNamed: "Futura-Medium")
        newLabel.text = text
        newLabel.fontSize = 14
        newLabel.fontColor = SKColor.whiteColor()
        newLabel.position.x = size.width / 2.0
        return newLabel
    }
    
    // not called, but required if you override SKScene's init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // present a new GameScene when user touches screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let scene = GameScene(size: self.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
    }
}
