//
//  Background.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class Background: NSView {
    
    var points:[CGPoint] = []
    var generator:ConvexHullGenerator!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if points.isEmpty {
            return
        }
        
        var path = CGPathCreateMutable()
        CGPathAddLines(path, nil, points, UInt(points.count))
        CGPathAddLineToPoint(path, nil, points[0].x, points[0].y)
        var context = NSGraphicsContext.currentContext()?.CGContext
        CGContextClearRect(context, NSRect(origin: CGPointZero, size: frame.size))
        CGContextAddPath(context, path)
        CGContextSetLineJoin(context, kCGLineJoinRound)
        CGContextSetLineWidth(context, 5.0)
        NSColor.redColor().setStroke()
        CGContextDrawPath(context, kCGPathStroke)

        
    }
    
    override func viewWillMoveToWindow(newWindow: NSWindow?) {
        generator = BruteForceCH()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let location = convertPoint(theEvent.locationInWindow, fromView: nil)
        points.append(location)
        addPointViews([location])
        makeConvexHull()
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let location =  convertPoint(theEvent.locationInWindow, fromView: nil)
        
    }
    
    func addPointViews(points:[CGPoint]) {
        let length:CGFloat = 25
        for location in points {
            let pointView = NSImageView(frame: NSRect(x: location.x - length/2, y: location.y - length/2, width: length, height: length))
            pointView.image = NSImage(named: "point")
            addSubview(pointView)
        }
    }
    
    func clearAllPoints() {
        subviews.removeAll(keepCapacity: false)
    }
    
    func makeConvexHull() {
        points = generator.generateConvexHull(points)
        clearAllPoints()
        addPointViews(points)
        setNeedsDisplayInRect(frame)
    }
    
}
