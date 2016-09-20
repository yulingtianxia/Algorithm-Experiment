//
//  GrahamScan.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/25.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa
import Foundation

class GrahamScan: NSObject,ConvexHullGenerator {
    var beginTime = Date(timeIntervalSince1970: 0)
    var endTime = Date(timeIntervalSince1970: 0)
    var costTime:TimeInterval {
        get{
            return endTime.timeIntervalSince(beginTime)
        }
    }
    func generateConvexHull(_ points: inout [PointView]) {
        beginTime = Date()
        for point in points {
            point.isConvexHullNode = true
        }
        
        if points.count <= 3 {
            return
        }
        
        var minYPoint = points[0]
        var minIndex = 0
        for (index,point) in points.enumerated() {
            (minIndex,minYPoint) = point.position.y < minYPoint.position.y ? (index,point) : (minIndex,minYPoint)
        }
        points.remove(at: minIndex)
        points.sort {
            return calculatePolarAngle(minYPoint.position, target: $0.position) < calculatePolarAngle(minYPoint.position, target: $1.position)
        }
        var stack = [minYPoint]
        var restPoints = [PointView]()
        stack.append(points[0])
        
        for point in points[1..<points.count] {
            
            func checkTurnsRight() -> Bool {
                let p1 = stack[stack.count-2].position
                let p2 = stack.last!.position
                let p3 = point.position
                let turnsRight = (p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x)
                return (turnsRight <= 0)
            }
            
            while checkTurnsRight() {
                stack.last?.isConvexHullNode = false
                restPoints.append(stack.last!)
                stack.removeLast()
                if stack.count < 3 {
                    break
                }
            }
            stack.append(point)
        }
        points = stack + restPoints
        endTime = Date()
    }
    
}
