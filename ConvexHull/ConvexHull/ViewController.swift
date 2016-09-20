//
//  ViewController.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

protocol ConvexHullGenerator{
    var beginTime:Date{get set}
    var endTime:Date{get set}
    var costTime:TimeInterval{get}
    func generateConvexHull(_ points:inout [PointView])
}

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }  

}

