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
    var algorithmSelected:Algorithm = Algorithm.bruteForceCH {
        willSet{
            switch newValue {
            case .bruteForceCH:
                generator = BruteForceCH()
            case .grahamScan:
                generator = GrahamScan()
            case .divideAndConquer:
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
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if points.isEmpty {
            return
        }
        
        let path = CGMutablePath()
        var locations:[CGPoint] = []
        for point in points {
            if point.isConvexHullNode {
                locations.append(point.position)
            }
        }
        path.addLines(between: locations)
        if !locations.isEmpty {
            path.closeSubpath()
        }
        let context = NSGraphicsContext.current()?.cgContext
        context?.clear(NSRect(origin: CGPoint.zero, size: frame.size))
        context?.addPath(path)
        context?.setLineJoin(CGLineJoin.round)
        context?.setLineWidth(5.0)
        NSColor.red.setStroke()
        context?.drawPath(using: CGPathDrawingMode.stroke)
        
        
    }
    
    override func viewWillMove(toWindow newWindow: NSWindow?) {
        super.viewWillMove(toWindow: newWindow)
        size = newWindow?.frame.size
//        generator = BruteForceCH()
        getAppDelegate().chooseDelegate = self
    }
    
    override func mouseUp(with theEvent: NSEvent) {
        if theEvent.clickCount > 1 {
            let location = convert(theEvent.locationInWindow, from: nil)
            addPont(location)
            makeConvexHull()
        }
    }
    
    func addPont(_ location:CGPoint) {
        let pointView = PointView(location: location)
        points.append(pointView)
        addSubview(pointView)
    }
    
    func clearPoints() {
        for point in points {
            point.removeFromSuperview()
        }
        points.removeAll(keepingCapacity: false)
    }
    
    func makeConvexHull() {
        generator?.generateConvexHull(&points)
        if let cost = generator?.costTime {
            (costTimeLabel.cell as! NSTextFieldCell).title = "\(cost*1000)"
        }
        else{
            (costTimeLabel.cell as! NSTextFieldCell).title = "no"
        }
        setNeedsDisplay(frame)
    }
    
    
    func createPointsWithNum(_ num:UInt32) {
        clearPoints()
        for _ in 0..<num {
            let x = CGFloat(powf(Float(arc4random_uniform(UInt32(pow(size.width,2)))), 0.5))
            let y = CGFloat(powf(Float(arc4random_uniform(UInt32(pow(size.height,2)))), 0.5))
            addPont(CGPoint(x: x, y: y))
        }
    }
    
    
}
