//
//  ViewController.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

protocol ConvexHullGenerator{
    func generateConvexHull(points:[CGPoint])->[CGPoint]
}

class ViewController: NSViewController {
    

//    var pointViews:[NSView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    
    

}

