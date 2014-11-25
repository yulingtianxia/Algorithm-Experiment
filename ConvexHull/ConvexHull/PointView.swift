//
//  PointView.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/25.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

private let length:CGFloat = 25

class PointView: NSImageView {
    
    var isConvexHullNode:Bool = false {
        willSet{
            if newValue {
                image = NSImage(named: "RedPoint")
            }
            else {
                image = NSImage(named: "point")
            }
        }
    }
    var position:CGPoint {
        set{
            frame.origin = CGPoint(x: newValue.x - length/2, y: newValue.y - length/2)
        }
        get{
            return CGPoint(x: frame.origin.x + length/2, y: frame.origin.y + length/2)
        }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    init(location:CGPoint) {
        super.init(frame: NSRect(x: location.x - length/2, y: location.y - length/2, width: length, height: length))
        image = NSImage(named: "point")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func mouseDragged(theEvent: NSEvent) {
        
        let delta = convertPoint(theEvent.locationInWindow, fromView: nil)
        if let location = superview?.convertPoint(theEvent.locationInWindow, fromView: nil) {
            position = location
            (superview as? Background)?.makeConvexHull()
        }
    }
    
    
    
    
}
