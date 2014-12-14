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
    var result:[PointView]?
    var generator:HamiltonianGenerator?
    var algorithmSelected:Algorithm = Algorithm.BaseTreeSearch {
        willSet{
            switch newValue {
            case .BaseTreeSearch:
                generator = BaseTreeSearching()
            case .HillClimbing:
                generator = BaseTreeSearching()
            case .MySearch:
                generator = MySearching()
            default:
                generator = BaseTreeSearching()
            }
            makeHamiltonian()
        }
    }
    var pointNumSelected:UInt32 = 0 {
        willSet{
            createPointsWithNum(newValue)
            makeHamiltonian()
        }
    }
    
    var size:CGSize!
    var linking:Bool = false {
        willSet{
            if !newValue {
                linkDestination = linkBlock()
            }
            else {
                linkSource = linkBlock()
            }
        }
        didSet{
            if !linking {
                linkDestination?.neighbours.addObject(linkSource!)
                linkSource?.neighbours.addObject(linkDestination!)
                linkSource = nil
                linkDestination = nil
            }
        }
    }
    var linkSource:PointView?
    var linkDestination:PointView?
    var linkBlock:()->PointView? = {return nil}
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        if points.isEmpty {
            return
        }
        
        var path = CGPathCreateMutable()
        for point in points {
            for neighbour in point.neighbours {
                CGPathMoveToPoint(path, nil, point.position.x, point.position.y)
                CGPathAddLineToPoint(path, nil, neighbour.position.x, neighbour.position.y)
            }
        }
        
        
        var context = NSGraphicsContext.currentContext()?.CGContext
        CGContextClearRect(context, NSRect(origin: CGPointZero, size: frame.size))
        CGContextAddPath(context, path)
        CGContextSetLineJoin(context, kCGLineJoinRound)
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, 5.0)
        NSColor.redColor().setStroke()
        CGContextDrawPath(context, kCGPathStroke)
        
        var hamiltonianPath = CGPathCreateMutable()
        var locations:[CGPoint] = []
        if result != nil {
            for point in result! {
                locations.append(point.position)
            }
        }
        CGPathAddLines(hamiltonianPath, nil, locations, UInt(locations.count))
        if !locations.isEmpty {
            CGPathCloseSubpath(hamiltonianPath)
        }
        CGContextAddPath(context, hamiltonianPath)
        NSColor.greenColor().setStroke()
        CGContextDrawPath(context, kCGPathStroke)
    }
    
    override func viewWillMoveToWindow(newWindow: NSWindow?) {
        super.viewWillMoveToWindow(newWindow)
        size = newWindow?.frame.size
        algorithmSelected = Algorithm.BaseTreeSearch
    }
    
    override func mouseUp(theEvent: NSEvent) {
        if theEvent.clickCount > 1 {
            let location = convertPoint(theEvent.locationInWindow, fromView: nil)
            addPont(location)
            makeHamiltonian()
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
    
    func makeHamiltonian(){
        result = generator?.generateHamiltonian(&points)
        if let cost = generator?.costTime {
            (costTimeLabel.cell() as NSTextFieldCell).title = "\(cost*1000)"
        }
        else{
            (costTimeLabel.cell() as NSTextFieldCell).title = "运行时间"
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
    
    @IBAction func radioButtonclicked(sender:NSMatrix){
        switch (sender.selectedCell() as NSButtonCell).title {
        case "基本搜索":
            algorithmSelected = Algorithm.BaseTreeSearch
        case "爬山法":
            algorithmSelected = Algorithm.HillClimbing
        case "个性优化":
            algorithmSelected = Algorithm.MySearch
        default:
            algorithmSelected = Algorithm.BaseTreeSearch
        }
    }
    
    
}
