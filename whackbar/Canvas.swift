//
//  Canvas.swift
//  whackbar
//
//  Created by Cameron on 04/07/2017.
//  Copyright © 2017 Cameron. All rights reserved.
//

import Foundation
import Cocoa
import SpriteKit

class WhackCanvas: SKView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let scene = WhackScene(size: frame.size)
        scene.isUserInteractionEnabled = true
        presentScene(scene)
        scene.scaleMode = .resizeFill
        scene.physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)
        scene.physicsWorld.contactDelegate = scene
    }
    
    override func touchesBegan(with event: NSEvent) {
        scene?.touchesBegan(with: event)
    }
    
    
}
