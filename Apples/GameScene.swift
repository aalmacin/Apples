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
    
    private var health = 100
    private var healthLabel:SKLabelNode! = nil
    private var score = 0
    private var scoreLabel:SKLabelNode! = nil
    
    private var boy:Boy! = nil
    private var currentTime:Int = 0
    
    private var currentVirusIndex = 0
    
    private let virusCount = 5
    private var viruses:[Virus] = []
    
    private var apple:Apple! = nil
    
    private let VIRUS_DEDUCTION = 10
    private let HEALTH_INCREASE = 20
    
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
        createScoreLabel()
        createViruses()
        createApple()
        
        createBoy()
    }
    
    func createHealthLabel() {
        healthLabel = SKLabelNode(fontNamed:"Chalkduster")
        healthLabel.text = "Health: \(health)%";
        healthLabel.fontSize = 16;
        healthLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 100, y:CGRectGetMaxY(self.frame) - 50)
        self.addChild(healthLabel)
    }
    
    func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed:"Chalkduster")
        scoreLabel.text = "Score: \(score)";
        scoreLabel.fontSize = 16;
        scoreLabel.position = CGPoint(x:CGRectGetMinX(self.frame) + 250, y:CGRectGetMaxY(self.frame) - 50)
        self.addChild(scoreLabel)
    }
    
    func createViruses() {
        for var i = 0; i < virusCount; i++ {
            var newVirus = Virus(sceneSize: size)
            let pos = CGFloat(arc4random_uniform(UInt32(self.size.width)))
            newVirus.position = CGPoint(x: pos, y: size.height + (newVirus.size.height * 2))
            viruses.append(newVirus)
            self.addChild(newVirus)
        }
    }
    
    func createApple() {
        apple = Apple(sceneSize: size)
        let pos = CGFloat(arc4random_uniform(UInt32(self.size.width)))
        apple.position = CGPoint(x: pos, y: size.height + (apple.size.height * 2))
        self.addChild(apple)
    }
    
    func createBoy() {
        boy = Boy(sceneSize: size)
        
        boy.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 150)
        self.addChild(boy)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            boy.move(location, scene: self)
            
        }
    }
    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        /* Called when a touch begins */
//        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//            boy.move(location, scene: self)
//            
//        }
//    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if (round(Float(self.currentTime)) < round(Float(currentTime))) {
            score++
            updateScore()
            self.currentTime = Int(round(Float(currentTime)))
            if(self.currentTime % 1 == 0) {
                viruses[currentVirusIndex].drop(self)
                
                currentVirusIndex++
                if(currentVirusIndex == virusCount) {
                    currentVirusIndex = 0
                }
            }
            if(self.currentTime % 9 == 0) {
                apple.drop(self)
            }
        }
    }
    
    private func hitVirus() {
        health -= VIRUS_DEDUCTION
        updateHealth()
    }
    
    private func hitApple() {
        health += HEALTH_INCREASE
        updateHealth()
    }
    
    private func updateHealth() {
        healthLabel.text = "Health: \(health)%";
    }
    
    private func updateScore() {
        scoreLabel.text = "Score: \(score)";
    }
    
    func isBoy(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Boy != 0
    }
    
    func isVirus(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Virus != 0
    }
    
    func isApple(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Apple != 0
    }
    
    func isWall(body:SKPhysicsBody) -> Bool {
        return body.categoryBitMask & CollisionCategory.Wall != 0
    }
    
    // called when collision starts
    func didBeginContact(contact: SKPhysicsContact) {
        var boy: SKPhysicsBody
        var otherBody: SKPhysicsBody
        
        // Find out which one is the boy body
        if isBoy(contact.bodyA) {
            boy = contact.bodyA
            otherBody = contact.bodyB
        } else {
            boy = contact.bodyB
            otherBody = contact.bodyA
        }
        
        // cannonball hit blocker, so play blocker sound
        if isVirus(otherBody) && isBoy(boy) {
            var virusNode = otherBody.node as Virus
            //virusNode.resetPosition(self)
            if(!virusNode.hit) {
                hitVirus()
            }
            virusNode.hit = true
        }
        
        // cannonball hit target
        if isApple(otherBody) && isBoy(boy) {
            var appleNode = otherBody.node as Apple
            //appleNode.resetPosition(self)
            if(!appleNode.hit) {
                hitApple()
            }
            appleNode.hit = true
        }
    }
}
