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
    var algorithmSelected:Algorithm = Algorithm.baseTreeSearch {
        willSet{
            switch newValue {
            case .baseTreeSearch:
                generator = BaseTreeSearching()
            case .hillClimbing:
                generator = HillClimbingSearch()
            case .mySearch:
                generator = MySearching()
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
                linkDestination?.neighbours.add(linkSource!)
                linkSource?.neighbours.add(linkDestination!)
                linkSource = nil
                linkDestination = nil
            }
        }
    }
    var linkSource:PointView?
    var linkDestination:PointView?
    var linkBlock:()->PointView? = {return nil}
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if points.isEmpty {
            return
        }
        
        let path = CGMutablePath()
        for point in points {
            for neighbour in point.neighbours {
                path.move(to: CGPoint(x: point.position.x, y: point.position.y))
                path.addLine(to: CGPoint(x: (neighbour as AnyObject).position.x, y: (neighbour as AnyObject).position.y))
            }
        }
        
        
        let context = NSGraphicsContext.current()?.cgContext
        context?.clear(NSRect(origin: CGPoint.zero, size: frame.size))
        context?.addPath(path)
        context?.setLineJoin(CGLineJoin.round)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5.0)
        NSColor.red.setStroke()
        context?.drawPath(using: CGPathDrawingMode.stroke)
        
        let hamiltonianPath = CGMutablePath()
        var locations:[CGPoint] = []
        if result != nil {
            for point in result! {
                locations.append(point.position)
            }
        }
        hamiltonianPath.addLines(between: locations)
        if !locations.isEmpty {
            hamiltonianPath.closeSubpath()
        }
        context?.addPath(hamiltonianPath)
        NSColor.green.setStroke()
        context?.drawPath(using: CGPathDrawingMode.stroke)
    }
    
    override func viewWillMove(toWindow newWindow: NSWindow?) {
        super.viewWillMove(toWindow: newWindow)
        size = newWindow?.frame.size
        algorithmSelected = Algorithm.baseTreeSearch
    }
    
    override func mouseUp(with theEvent: NSEvent) {
        if theEvent.clickCount > 1 {
            let location = convert(theEvent.locationInWindow, from: nil)
            addPont(location)
            makeHamiltonian()
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
    
    func makeHamiltonian(){
        result = generator?.generateHamiltonian(&points)
        if let cost = generator?.costTime {
            (costTimeLabel.cell as! NSTextFieldCell).title = "\(cost*1000)"
        }
        else{
            (costTimeLabel.cell as! NSTextFieldCell).title = "运行时间"
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
    
    @IBAction func radioButtonclicked(_ sender:NSMatrix){
        switch (sender.selectedCell() as! NSButtonCell).title {
        case "基本搜索":
            algorithmSelected = Algorithm.baseTreeSearch
        case "爬山法":
            algorithmSelected = Algorithm.hillClimbing
        case "个性优化":
            algorithmSelected = Algorithm.mySearch
        default:
            algorithmSelected = Algorithm.baseTreeSearch
        }
    }
    
    
}
