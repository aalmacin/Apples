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
        
        var bgNode = SKSpriteNode(
            texture: SKTexture(imageNamed: "GameBackground"),
            color: nil,
            size: self.size
        )
        bgNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(bgNode)
        
        // Create the main header label
        let instructionsHeaderLabel = SKLabelNode(fontNamed: "Futura-Medium")
        instructionsHeaderLabel.text = "Instructions"
        instructionsHeaderLabel.fontSize = 18
        instructionsHeaderLabel.fontColor = SKColor.whiteColor()
        instructionsHeaderLabel.position = CGPoint(x:size.width / 2.0, y: size.height - 100 + instructionsHeaderLabel.fontSize)
        
        self.addChild(instructionsHeaderLabel)
        
        // Create the instruction labels
        let instructionsLabel1 = createInstructionsLabel("You will lose 10% health by getting hit by viruses.")
        instructionsLabel1.position.y = instructionsHeaderLabel.position.y - 50 + instructionsLabel1.fontSize
        self.addChild(instructionsLabel1)
        
        let instructionsLabel2 = createInstructionsLabel("You'll gain 20% health and 20 points when hit by an apple.")
        instructionsLabel2.position.y = instructionsLabel1.position.y - 50 + instructionsLabel2.fontSize
        self.addChild(instructionsLabel2)
        
        let instructionsLabel3 = createInstructionsLabel("Stay alive and gain points every second.")
        instructionsLabel3.position.y = instructionsLabel2.position.y - 50 + instructionsLabel3.fontSize
        self.addChild(instructionsLabel3)
        
        let instructionsLabel4 = createInstructionsLabel("When your health goes down to 0%, the game is over.")
        instructionsLabel4.position.y = instructionsLabel3.position.y - 50 + instructionsLabel4.fontSize
        self.addChild(instructionsLabel4)
        //
        
        // Create the label that tells the user that he will return to the main game scene/main menu by clicking anywhere
        let goBackLabel = SKLabelNode(fontNamed: "Futura-Medium")
        goBackLabel.text = "Touch anywhere to go back"
        goBackLabel.fontSize = 16
        goBackLabel.fontColor = SKColor.whiteColor()
        goBackLabel.position = CGPoint(x:size.width / 2.0, y: instructionsLabel4.position.y - 100 + instructionsHeaderLabel.fontSize);
        
        self.addChild(goBackLabel)
    }
    
    // Create instructions label using this method.
    private func createInstructionsLabel(text: String) -> SKLabelNode {
        let newLabel = SKLabelNode(fontNamed: "Futura-Medium")
        newLabel.text = text
        newLabel.fontSize = 14
        newLabel.fontColor = SKColor.whiteColor()
        newLabel.position.x = size.width / 2.0
        return newLabel
    }
    
    // When the user touches anywhere, the main game scene will be shown.
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let scene = MainGameScene(size: self.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
