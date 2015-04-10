//
//  GameOverScene.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//
import SpriteKit

class GameOverScene: SKScene {
    // configure GameOverScene
    init(size: CGSize, score: Int) {
        super.init(size: size)
        self.backgroundColor = SKColor.brownColor()
        
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 60
        gameOverLabel.fontColor = SKColor.whiteColor()
        gameOverLabel.position.x = size.width / 2.0
        gameOverLabel.position.y =
            size.height / 2.0 + gameOverLabel.fontSize
        self.addChild(gameOverLabel)
        
        let elapsedTimeLabel = SKLabelNode(fontNamed: "Chalkduster")
        elapsedTimeLabel.text = "Final Score: \(score)"
        elapsedTimeLabel.fontSize = 24
        elapsedTimeLabel.fontColor = SKColor.whiteColor()
        elapsedTimeLabel.position.x = size.width / 2.0
        elapsedTimeLabel.position.y = size.height / 2.0
        self.addChild(elapsedTimeLabel)
        
        let newGameLabel = SKLabelNode(fontNamed: "Chalkduster")
        newGameLabel.text = "Begin New Game"
        newGameLabel.fontSize = 24
        newGameLabel.fontColor = SKColor.whiteColor()
        newGameLabel.position.x = size.width / 2.0
        newGameLabel.position.y =
            size.height / 2.0 - gameOverLabel.fontSize
        self.addChild(newGameLabel)
    }
    
    // not called, but required if you override SKScene's init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // present a new GameScene when user touches screen
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let scene = MainGameScene(size: self.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene, transition: SKTransition.crossFadeWithDuration(1.0))
    }
}
