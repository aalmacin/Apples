//
//  MainGameScene
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//

// Learned most of the coding techniques from the book we use for class. Some of the code may look similar to the cannon game app but we did not copy from the app. Some of the implementation may be the same due to the coding style and techniques we have learned from reading the book.

import SpriteKit


// Power of two, collision categories
struct CollisionCategory {
    static let Boy : UInt32 = 1
    static let Virus : UInt32 = 1 << 1
    static let Apple : UInt32 = 1 << 2
}

// The main game scene. Contains the game logic, collision detection, main menu, and event listeners
class MainGameScene: SKScene, SKPhysicsContactDelegate {
    
    
    // Health points and score variables and labels
    private var health = 100
    private var healthLabel:SKLabelNode! = nil
    private var score = 0
    private var scoreLabel:SKLabelNode! = nil
    
    // Start and instructions button
    private var startButton:SKSpriteNode! = nil
    private var instructionsButton:SKSpriteNode! = nil
    
    // Instance of boy
    private var boy:Boy! = nil
    
    // Keeps track of how many seconds since the game started
    private var currentTime:Int = 0
    
    // Current virus to drop
    private var currentVirusIndex = 0
    
    // The number of viruses and an array which will contain all the viruses
    private let virusCount = 4
    private var viruses:[Virus] = []
    
    // Instance of the apple to be dropped.
    private var apple:Apple! = nil
    
    // Constants which contains
    private let VIRUS_DEDUCTION = 10
    private let HEALTH_INCREASE = 20
    private let SCORE_INCREASE = 20
    
    // Check whether the game started
    private var start = false
    
    
    // When the scene gets presented, this function will run
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.brownColor()
        
        var bgNode = SKSpriteNode(
            texture: SKTexture(imageNamed: "GameBackground"),
            color: nil,
            size: self.size
        )
        bgNode.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(bgNode)
        
        
        // Set the gravity to none. We don't want to pull the objects. We don't actually need physics other than for collision
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        
        // Set Variables to initial values
        start = false
        currentTime = 0
        health = 100
        score = 0
        
        
        // Call initialization methods
        createHealthLabel()
        createScoreLabel()
        createViruses()
        createApple()
        createBoy()
        createButtons()
    }
    
    // Creates the health label for the game and set it's position on the screen
    func createHealthLabel() {
        healthLabel = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        healthLabel.text = "Health: \(health)%";
        healthLabel.fontSize = 16;
        healthLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:CGRectGetMaxY(self.frame) - 50)
        
        // Add the label to the scene
        self.addChild(healthLabel)
    }
    
    // Creates the score label for the game and set it's position on the screen
    func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed:"MarkerFelt-Wide")
        scoreLabel.text = "Score: \(score)";
        scoreLabel.fontSize = 16;
        scoreLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 250, y:CGRectGetMaxY(self.frame) - 50)
        
        // Add the label to the scene
        self.addChild(scoreLabel)
    }
    
    // Creates the viruses which are the main enemies in the game
    func createViruses() {
        for var i = 0; i < virusCount; i++ {
            // Create a new virus passing this screen's size
            var newVirus = Virus(sceneSize: size, imageNamed: "Virus\(i+1)")
            let pos = CGFloat(arc4random_uniform(UInt32(self.size.width)))
            
            // Set the position outside the screen
            newVirus.position = CGPoint(x: pos, y: size.height + (newVirus.size.height * 2))
            
            // Add the new Virus to the viruses array
            viruses.append(newVirus)
            
            // Add the virus to the scene
            self.addChild(newVirus)
        }
    }
    
    // Creates the apple which helps the player stay alive by adding health.
    func createApple() {
        // Create a new apple passing this screen's size
        apple = Apple(sceneSize: size, imageNamed: "apple")
        let pos = CGFloat(arc4random_uniform(UInt32(self.size.width)))
        
        // Set the position outside the screen
        apple.position = CGPoint(x: pos, y: size.height + (apple.size.height * 2))
        
        // Add the apple to the scene
        self.addChild(apple)
    }
    
    // Create the Boy - The player's avatar
    func createBoy() {
        boy = Boy(sceneSize: size) // Pass this scene's size and create the boy object
        
        // Position the boy in the middle of the screen
        boy.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 150)
        
        // Add the boy to the scene
        self.addChild(boy)
    }
    
    // Create the buttons with labels for the main menu
    func createButtons() {
        // Save this colour for the button's colour
        let buttonsColourGreen:SKColor = SKColor(red: 0.706, green: 0.992, blue: 0.753, alpha: 1.0)
        
        // Create start button
        startButton = SKSpriteNode(color: SKColor.purpleColor(), size: CGSize(width: 200, height: 50))
        startButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + startButton.size.height);
        
        // Create the label for the button
        var startLabel = SKLabelNode(
            fontNamed:"BradleyHandITCTT-Bold"
        )
        startLabel.text = "Start"
        startLabel.fontSize = 20
        startLabel.fontColor = buttonsColourGreen
        
        // Add the label to the button
        startButton.addChild(startLabel)
        
        // Add the button to the scene
        self.addChild(startButton)
        
        // Create the button
        instructionsButton = SKSpriteNode(color: SKColor.purpleColor(), size: CGSize(width: 200, height: 50))
        instructionsButton.position = CGPoint(x:CGRectGetMidX(self.frame), y: startButton.position.y - (startButton.size.height * 2));
        
        var instructionsLabel = SKLabelNode(
            fontNamed:"BradleyHandITCTT-Bold"
        )
        instructionsLabel.text = "Instructions"
        instructionsLabel.fontSize = 20
        instructionsLabel.fontColor = buttonsColourGreen
        
        // Add the label to the button
        instructionsButton.addChild(instructionsLabel)
        
        // Add the button to the scene
        self.addChild(instructionsButton)
    }
    
    // Everytime the user touches the screen when the game is started, call the move method on the player object
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if self.start {
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                // Send the location to the move method on the boy object.
                boy.move(location, scene: self)
            }
        }
    }
   
    
    // Everytime the frames update, this method will run. This method is used to update the time and drop apples and viruses
    override func update(currentTime: CFTimeInterval) {
        // Check if the player already clicked start
        if(self.start) {
            // Check if the time elapsed changed.
            if (round(Float(self.currentTime)) < round(Float(currentTime))) {
                // Increase the player's score
                score++
                
                // Update the score label
                updateScore()
                
                // Set the current time field to the int version of currentTime
                self.currentTime = Int(round(Float(currentTime)))
                
                // Call virus object drop method every second
                if(self.currentTime % 1 == 0) {
                    viruses[currentVirusIndex].drop(self)
                    
                    // Update the current virus index and reset the index when needed
                    currentVirusIndex++
                    if(currentVirusIndex == virusCount) {
                        currentVirusIndex = 0
                    }
                }
                
                // Call the method drop on the apple object every 8 seconds
                if(self.currentTime % 8 == 0) {
                    apple.drop(self)
                }
            }
            
            // If health goes down to zero, call the gameOver method
            if health <= 0 {
                runAction(SKAction.runBlock({self.gameOver()}))
            }
        }
    }
    
    // Decreases health points and updates the health label when hit by a virus
    private func hitVirus() {
        health -= VIRUS_DEDUCTION
        updateHealth()
    }
    
    // Increases health points and updates the health label when hit by an apple
    private func hitApple() {
        health += HEALTH_INCREASE
        
        // Do not let the health go above 100
        if(health > 100) {
            health = 100
        }
        
        // Increase the score
        score += SCORE_INCREASE
        
        // Update the label
        updateHealth()
    }
    
    // Methods to update health and score labels

    private func updateHealth() {
        healthLabel.text = "Health: \(health)%";
    }
    
    private func updateScore() {
        scoreLabel.text = "Score: \(score)";
    }
    
    // Methods which returns a boolean value after checking if the category bitmask of the physics body compared with the collision does not return 000000
    // If it does, then that means that the collision category does not match the physicsBody passed as a parameter.
    
    func isBoy(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Boy != 0
    }
    
    func isVirus(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Virus != 0
    }
    
    func isApple(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Apple != 0
    }
    
    // called when collision starts
    func didBeginContact(contact: SKPhysicsContact) {
        var boy: SKPhysicsBody
        var otherBody: SKPhysicsBody
        
        // Find out which one is the boy physics body
        if isBoy(contact.bodyA) {
            boy = contact.bodyA
            otherBody = contact.bodyB
        } else {
            boy = contact.bodyB
            otherBody = contact.bodyA
        }
        
        // Check if the virus and boy hit each other
        if isVirus(otherBody) && isBoy(boy) {
            // get the node from the physics body and cast it to a virus object
            var virusNode = otherBody.node as Virus
            // if the virus is not currently being hit, call the hit Virus method to decrease the player's points
            if(!virusNode.hit) {
                hitVirus()
            }
            
            // Hide the virus node and set its hit field to true
            virusNode.hidden = true
            virusNode.hit = true
        }
        
        // Apple and boy collides
        if isApple(otherBody) && isBoy(boy) {
            // get the node from the physics body and cast it to an apple object
            var appleNode = otherBody.node as Apple
            // Call hit apple method when the apple is hit for the first time
            if(!appleNode.hit) {
                hitApple()
            }
            // Hide the apple node and set its hit field to true
            appleNode.hidden = true
            appleNode.hit = true
        }
    }
    
    // display the game over scene
    func gameOver() {
        let gameOverScene = GameOverScene(size: self.size, score: self.score)
        gameOverScene.scaleMode = .AspectFill
        self.view?.presentScene(gameOverScene)
    }
    
    // display the instructions scene
    func instructions() {
        let instructionsScene = InstructionsScene(size: self.size)
        instructionsScene.scaleMode = .AspectFill
        self.view?.presentScene(instructionsScene)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if !self.start {
            for touch: AnyObject in touches {
                let location = touch.locationInNode(self)
                
                // If Startbutton is touched, set the game to start and hide the buttons
                if startButton.containsPoint(location) {
                    self.start = true
                    startButton.hidden = true
                    instructionsButton.hidden = true
                }
                
                // If Instructions Button is touched, call the instructions method which will eventually present the InstructionsScene
                if instructionsButton.containsPoint(location) {
                    instructions()
                }
            }
        }
    }
}
