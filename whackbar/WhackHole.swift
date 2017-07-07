//
//  WhackHole.swift
//  whackbar
//
//  Created by Cameron on 04/07/2017.
//  Copyright © 2017 Cameron. All rights reserved.
//

import Cocoa
import SpriteKit

class WhackHole: SKNode {
    
    var hasBeenHit = false
    var isVisible = false
    var charNode:SKSpriteNode!

    func configurePos(pos: CGPoint) {
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "hole")
        sprite.size = CGSize(width: 50, height: 12)
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 0)
        cropNode.zPosition = 1
       // cropNode.maskNode = SKSpriteNode(imageNamed: "testmask")
        cropNode.maskNode = nil

        
        charNode = SKSpriteNode(imageNamed: "iphone")
        charNode.size = CGSize(width: 50, height: 28)
        charNode.name = "gooditem"
        // y: 10 ... y: -20
        charNode.position = CGPoint(x: 0, y: -20)
        cropNode.addChild(charNode)
        addChild(cropNode)
        
     //   showPhone(hideTime: 3)
        
        
    }
    
    func showPhone(hideTime: Double) {
        if isVisible { return }
        

        charNode.run(SKAction.moveBy(x: 0, y: 30, duration: 0.15))
        isVisible = true
        hasBeenHit = false
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        if Int(arc4random_uniform(3)) == 0 {
            charNode.texture = SKTexture(imageNamed: "samsungtest")
            charNode.name = "bad"
        } else {
            charNode.texture = SKTexture(imageNamed: "iphone")
            charNode.name = "good"
        }
        
        let when = DispatchTime.now() + .seconds(Int(hideTime))
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.hide()
        }
        
    }
    
    func hide() {
        if !isVisible { return }
        charNode.run(SKAction.moveBy(x: 0, y: -30, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        hasBeenHit = true
        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -30, duration: 0.5)
        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        charNode.run(SKAction.sequence([delay, hide, notVisible]))

    }
    
}
