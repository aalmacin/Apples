//
//  GameOverScene.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
// Shows the final score and makes the player play again

import SpriteKit

class GameOverScene: SKScene {
    init(size: CGSize, score: Int) {
        super.init(size: size)
        self.backgroundColor = SKColor.brownColor()
        
        var background = SKSpriteNode(
            texture: SKTexture(imageNamed: "GameBackground"),
            color: nil,
            size: self.size
        )
        background.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(background)
        
        // Create a colour to be used.
        let labelColourGreen:SKColor = SKColor(red: 0.706, green: 0.992, blue: 0.753, alpha: 1.0)
        
        // Set the Labels to show. Final score and a message telling the user to click anywhere to play the game again.
        let elapsedTimeLabel = SKLabelNode(fontNamed: "Futura-Medium")
        elapsedTimeLabel.text = "Final Score: \(score)"
        elapsedTimeLabel.fontSize = 40
        elapsedTimeLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        elapsedTimeLabel.fontColor = labelColourGreen
        self.addChild(elapsedTimeLabel)
        
        // Create the label that tells the user that he will return to the main game scene/main menu by clicking anywhere
        let newGameLabel = SKLabelNode(fontNamed: "Futura-Medium")
        newGameLabel.text = "Touch anywhere to play again"
        newGameLabel.fontSize = 24
        newGameLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: elapsedTimeLabel.position.y + (elapsedTimeLabel.fontSize * 2));
        newGameLabel.fontColor = labelColourGreen
        self.addChild(newGameLabel)
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
