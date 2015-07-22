//
//  Background.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa
import AppKit

class Background: NSView, ChooseAlgorithm {
    
    @IBOutlet weak var costTimeLabel: NSTextField!
    var points:[PointView] = []
    var generator:ConvexHullGenerator?
    var algorithmSelected:Algorithm = Algorithm.BruteForceCH {
        willSet{
            switch newValue {
            case .BruteForceCH:
                generator = BruteForceCH()
            case .GrahamScan:
                generator = GrahamScan()
            case .DivideAndConquer:
                generator = DivideAndConquer()
            }
            makeConvexHull()
        }
    }
    var pointNumSelected:UInt32 = 0 {
        willSet{
            createPointsWithNum(newValue)
            makeConvexHull()
        }
    }
    var size:CGSize!
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if points.isEmpty {
            return
        }
        
        let path = CGPathCreateMutable()
        var locations:[CGPoint] = []
        for point in points {
            if point.isConvexHullNode {
                locations.append(point.position)
            }
        }
        CGPathAddLines(path, nil, &locations, locations.count)
        if !locations.isEmpty {
            CGPathCloseSubpath(path)
        }
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextClearRect(context, NSRect(origin: CGPointZero, size: frame.size))
        CGContextAddPath(context, path)
        CGContextSetLineJoin(context, CGLineJoin.Round)
        CGContextSetLineWidth(context, 5.0)
        NSColor.redColor().setStroke()
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        
        
    }
    
    override func viewWillMoveToWindow(newWindow: NSWindow?) {
        super.viewWillMoveToWindow(newWindow)
        size = newWindow?.frame.size
//        generator = BruteForceCH()
        getAppDelegate().chooseDelegate = self
    }
    
    override func mouseUp(theEvent: NSEvent) {
        if theEvent.clickCount > 1 {
            let location = convertPoint(theEvent.locationInWindow, fromView: nil)
            addPont(location)
            makeConvexHull()
        }
    }
    
    func addPont(location:CGPoint) {
        let pointView = PointView(location: location)
        points.append(pointView)
        addSubview(pointView)
    }
    
    func clearPoints() {
        for point in points {
            point.removeFromSuperview()
        }
        points.removeAll(keepCapacity: false)
    }
    
    func makeConvexHull() {
        generator?.generateConvexHull(&points)
        if let cost = generator?.costTime {
            (costTimeLabel.cell as! NSTextFieldCell).title = "\(cost*1000)"
        }
        else{
            (costTimeLabel.cell as! NSTextFieldCell).title = "no"
        }
        setNeedsDisplayInRect(frame)
    }
    
    
    func createPointsWithNum(num:UInt32) {
        clearPoints()
        for _ in 0..<num {
            let x = CGFloat(powf(Float(arc4random_uniform(UInt32(pow(size.width,2)))), 0.5))
            let y = CGFloat(powf(Float(arc4random_uniform(UInt32(pow(size.height,2)))), 0.5))
            addPont(CGPoint(x: x, y: y))
        }
    }
    
    
}
