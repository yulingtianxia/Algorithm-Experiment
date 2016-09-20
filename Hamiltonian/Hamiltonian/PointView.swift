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
    
    var position:CGPoint {
        set{
            frame.origin = CGPoint(x: newValue.x - length/2, y: newValue.y - length/2)
        }
        get{
            return CGPoint(x: frame.origin.x + length/2, y: frame.origin.y + length/2)
        }
    }
    
    var neighbours:NSMutableSet = NSMutableSet()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    init(location:CGPoint) {
        super.init(frame: NSRect(x: location.x - length/2, y: location.y - length/2, width: length, height: length))
        image = NSImage(named: "point")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDragged(with theEvent: NSEvent) {
//        let delta = convertPoint(theEvent.locationInWindow, fromView: nil)
        if let location = superview?.convert(theEvent.locationInWindow, from: nil) {
            position = location
            (superview as? Background)?.setNeedsDisplay(superview!.frame)
        }
    }

    override func rightMouseUp(with theEvent: NSEvent) {
        if (superview as! Background).linking {
            (superview as! Background).linkBlock = {self}
            (superview as! Background).linking = false
            (superview as? Background)?.makeHamiltonian()
        }
        else{
            (superview as! Background).linkBlock = {self}
            (superview as! Background).linking = true
        }
    }
    
    
}
