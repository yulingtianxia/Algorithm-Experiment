//
//  Background.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class Background: NSView {
    
    var points:[PointView] = []
    var generator:ConvexHullGenerator!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if points.isEmpty {
            return
        }
        
        var path = CGPathCreateMutable()
        var locations:[CGPoint] = []
        for point in points {
            if point.isConvexHullNode {
                locations.append(point.position)
            }
        }
        CGPathAddLines(path, nil, locations, UInt(locations.count))
        CGPathCloseSubpath(path)
        var context = NSGraphicsContext.currentContext()?.CGContext
        CGContextClearRect(context, NSRect(origin: CGPointZero, size: frame.size))
        CGContextAddPath(context, path)
        CGContextSetLineJoin(context, kCGLineJoinRound)
        CGContextSetLineWidth(context, 5.0)
        NSColor.redColor().setStroke()
        CGContextDrawPath(context, kCGPathStroke)

        
    }
    
    override func viewWillMoveToWindow(newWindow: NSWindow?) {
        super.viewWillMoveToWindow(newWindow)
        generator = BruteForceCH()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        if theEvent.clickCount > 1 {
            let location = convertPoint(theEvent.locationInWindow, fromView: nil)
            let pointView = PointView(location: location)
            points.append(pointView)
            addSubview(pointView)
            makeConvexHull()
        }
    }
    
    func makeConvexHull() {
        generator.generateConvexHull(&points)
        setNeedsDisplayInRect(frame)
    }
    
    
    
}
