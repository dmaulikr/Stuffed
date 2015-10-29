//
//  GameBoardScene.swift
//  Stuffed
//
//  Created by Mac Bellingrath on 10/27/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import SpriteKit

typealias DisplayName = String
typealias PlayerPixel = [DisplayName: SKShapeNode]
typealias PlayerCurrentDirection = [DisplayName:PlayerDirection]


enum PlayerDirection: String { case Left =  "left" , Right = "right"
    var dValue: CGFloat {
        return self == .Left ? -1 : 1
    }
}



class GameBoardScene: SKScene {
    
    var playerPixels: PlayerPixel = [:]
    var currentDirections: PlayerCurrentDirection = [:]

    override func didMoveToView(view: SKView) {
        physicsBody =  SKPhysicsBody(edgeLoopFromRect: frame)
        physicsBody?.categoryBitMask = 0b1
        
        physicsWorld.contactDelegate = self
        
    
    }

    
    func addPixel(name: DisplayName, colorName: String = "blue") {
    
        let pixel = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        pixel.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        pixel.fillColor = colors[colorName] ?? UIColor.blueColor()
        
        pixel.physicsBody = SKPhysicsBody(rectangleOfSize: pixel.frame.size)
        pixel.name = String(name)
        
        pixel.physicsBody?.categoryBitMask = 0b1
        
        
        addChild(pixel)
        
        playerPixels[name] = pixel
        currentDirections[name] = .Right
        
    }
    typealias Action = String?
    
    func pixel(name: DisplayName) -> Action -> () {
         let pixel = playerPixels[name]
        return { action in if let x = action  {
            let offsetX = x == "right" ? 50 : x == "left" ? -50 : 0
            let offsetY = 0
            
            pixel?.physicsBody?.applyForce(CGVector(dx: offsetX, dy: offsetY))

        } else if let jump = action where jump == "jump"{
            
            //left
            let pixel = self.playerPixels[name]
            
            pixel?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))

            }
        }
    }
    
    
    func firePixel(name: DisplayName) {
        
        if let pixel = playerPixels[name] {
        let fireball = SKShapeNode(rectOfSize: CGSize(width: 5, height: 5))
            fireball.name = Names.Fireball.rawValue
            
            fireball.physicsBody?.contactTestBitMask = 0b1
            fireball.physicsBody?.categoryBitMask = 0b1
            
            
            fireball.fillColor = pixel.fillColor
            fireball.physicsBody = SKPhysicsBody(rectangleOfSize: fireball.frame.size)
            fireball.physicsBody?.affectedByGravity = false
            
            addChild(fireball)
            
            let d = currentDirections[name]
            
            
            let offsetX = (d?.dValue ?? 0) * 100
            
            
            fireball.position.y = pixel.position.y
            fireball.position.x = pixel.position.x + (d?.dValue ?? 0) * 21

            
            fireball.physicsBody?.applyForce(CGVector(dx: offsetX, dy: 0))
        }
    }
    
    
    func movePixel(name: DisplayName, direction: String) {
        
        let pixel = playerPixels[name]
        let d = PlayerDirection(rawValue: direction)
        
//        let offsetX = direction == "right" ? 50 : direction == "left" ? -50 : 0
//        let offsetY = 0
        let offsetX = d?.dValue ?? 0 * 50
       
        pixel?.physicsBody?.applyForce(CGVector(dx: offsetX, dy: 0))
        
        currentDirections[name] = d
    }
    func jumpPixel(name: DisplayName) {
        
       playerPixels[name]?.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
        
    }
    
    func removePixel(name: DisplayName) {
      playerPixels[name]?.removeFromParent()
    }
}


extension GameBoardScene: SKPhysicsContactDelegate {
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    
       
        if let nodeA = contact.bodyA.node as? SKShapeNode where nodeA.name == Names.Fireball.rawValue {
            nodeA.removeFromParent()
        }
        
        if let nodeB = contact.bodyB.node as? SKShapeNode where nodeB.name == Names.Fireball.rawValue {
            nodeB.removeFromParent()
        }
        
    }
    
   
    
    
}