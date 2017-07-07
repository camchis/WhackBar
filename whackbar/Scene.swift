//
//  Scene.swift
//  whackbar
//
//  Created by Cameron on 04/07/2017.
//  Copyright © 2017 Cameron. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit


class WhackScene: SKScene, SKPhysicsContactDelegate {
    
    let mainview = ViewController()
    
    var currentphones = [WhackHole]()
    var waitTime = 0.85
    var score = 0
    var rounds = 0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: 342.5, y: 15.1185607910156)
        background.blendMode = .replace
        addChild(background)
      //  createHole(pos: CGPoint(x: 100, y: 6))
        for i in 1..<7 {
            createHole(pos: CGPoint(x: (100*i), y: 6))
        }
        let when = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.emerge()
        }
    }

    func emerge() {
        rounds = rounds + 1
        if rounds >= 12 {
            for node in currentphones {
                node.hide()
            }
            textField?.textColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1)
            let gameover = SKSpriteNode(imageNamed: "gameover")
            gameover.size = CGSize(width: 500, height: 30)
            gameover.position = CGPoint(x: 360, y: 14)
            addChild(gameover)
            return
        }
        waitTime += 0.05
        GKRandomSource.sharedRandom().arrayByShufflingObjects(in: currentphones)

        if Int(arc4random_uniform(100)) < 60 { currentphones[0].showPhone(hideTime: waitTime) }
        if Int(arc4random_uniform(100)) < 40 { currentphones[1].showPhone(hideTime: waitTime) }
        if Int(arc4random_uniform(100)) < 40 { currentphones[2].showPhone(hideTime: waitTime) }
        if Int(arc4random_uniform(100)) < 80 { currentphones[3].showPhone(hideTime: waitTime) }
        if Int(arc4random_uniform(100)) < 70 { currentphones[4].showPhone(hideTime: waitTime) }
        if Int(arc4random_uniform(100)) < 50 { currentphones[5].showPhone(hideTime: waitTime) }

 
        let minDelay = waitTime / 2.0
        let maxDelay = waitTime * 2.0
        
        let delay = Int(arc4random_uniform(UInt32(maxDelay - minDelay)) + UInt32(maxDelay))

        let when = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.emerge()
        }
        
    }
    
    
    
    func createHole(pos: CGPoint) {
        let slot = WhackHole()
        slot.configurePos(pos: pos)
        addChild(slot)
        currentphones.append(slot)
        print(currentphones.count)
    }
    

    func updateScore() {
        textField?.stringValue = String(score)
    }

    override func touchesBegan(with event: NSEvent) {
        if #available(OSX 10.12.2, *) {
            if let touch = event.allTouches().first {
                let location = CGPoint(x: touch.location(in: self.view).x, y: touch.location(in: self.view).y)

                let nodepressed = nodes(at: location)
                print(nodepressed)
                for node in nodepressed {
                    if node.name != nil {
                        if node.name == "good" {
                            let slot = node.parent!.parent as! WhackHole
                            if (!slot.isVisible) { continue }
                            if (slot.hasBeenHit) { continue }
                            
                            score = score-10
                            updateScore()
                            textField?.textColor = NSColor(calibratedRed: 1.000, green:0.137, blue:0.137, alpha:1.0)
                            
                            slot.hit()
                            run(SKAction.playSoundFileNamed("badwav.wav", waitForCompletion: false))
                            
                            
                        } else {
                            
                            let slot = node.parent!.parent as! WhackHole
                            if (!slot.isVisible) { continue }
                            if (slot.hasBeenHit) { continue }
                            
                            slot.charNode.xScale = 0.75
                            slot.charNode.yScale = 0.75
                
                            score = score+5
                            updateScore()
                            
                            textField?.textColor = NSColor(red: 0.9, green: 0, blue: 0, alpha: 1)



                            slot.hit()
                            run(SKAction.playSoundFileNamed("goodhit.mp3", waitForCompletion: false))
                        }

                    }
                }
/*
                    if node.name == "good" {
                        vc.alabel.stringValue = "good"
                    } else if node.name == "bad" {
                        vc.alabel.stringValue = "bad"
                    }
 */
                }
            }
        }
    }
    




