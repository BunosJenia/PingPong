//
//  GameScene.swift
//  PingPong
//
//  Created by Yauheni Bunas on 7/7/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var mainPlayerScoreLabel = SKLabelNode()
    var enemyPlayerScoreLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        mainPlayerScoreLabel = self.childNode(withName: "mainPlayerScoreLabel") as! SKLabelNode
        enemyPlayerScoreLabel = self.childNode(withName: "enemyPlayerScoreLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        enemy.position.y = self.frame.height / 2 - 70
        main.position.y = -self.frame.height / 2 + 70
        
        enemy.size.width = self.frame.width / 5
        main.size.width = self.frame.width / 5
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        
        mainPlayerScoreLabel.text = "\(score[0])"
        enemyPlayerScoreLabel.text = "\(score[1])"
        
        pushTheBall(playerWhoWon: main)
    }
    
    func pushTheBall(playerWhoWon: SKSpriteNode) {
        var dx = 10
        var dy = 10
        
        if playerWhoWon == main {
            dx = -dx
            dy = -dy
        }
        
        let wait = SKAction.wait(forDuration: 1)
        
        let changeScene = SKAction.run {
            self.ball.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        }
        
        let sequence = SKAction.sequence([wait, changeScene])
        self.run(SKAction.repeat(sequence, count: 1))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            pushTheBall(playerWhoWon: enemy)
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            pushTheBall(playerWhoWon: main)
        }
        
        mainPlayerScoreLabel.text = "\(score[0])"
        enemyPlayerScoreLabel.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.18))
            break
        case .player2:
            
            break
        }
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
}
