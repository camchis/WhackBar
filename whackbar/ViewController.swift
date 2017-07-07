//
//  ViewController.swift
//  whackbar
//
//  Created by Cameron on 04/07/2017.
//  Copyright © 2017 Cameron. All rights reserved.
//

import Cocoa

public var textField: NSTextField?


class ViewController: NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font: NSFont = .systemFont(ofSize: 40)
        textField = NSTextField(frame: NSRect(x: 202, y: 109, width: 77, height: 51))
        textField!.font = font
        textField!.alignment = NSTextAlignment.center
        textField!.isBezeled = false
        textField!.drawsBackground = false
        textField!.isEditable = false
        textField!.isSelectable = false
        textField?.stringValue = "0"

        self.view.addSubview(textField!) 
    }
    

    

    override var representedObject: Any? {
        didSet {

    }
    

    }
}
