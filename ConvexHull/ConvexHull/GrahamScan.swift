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
    var beginTime = NSDate(timeIntervalSince1970: 0)
    var endTime = NSDate(timeIntervalSince1970: 0)
    var costTime:NSTimeInterval {
        get{
            return endTime.timeIntervalSinceDate(beginTime)
        }
    }
    func generateConvexHull(inout points: [PointView]) {
        beginTime = NSDate()
        for point in points {
            point.isConvexHullNode = true
        }
        
        if points.count <= 3 {
            return
        }
        
        var minYPoint = points[0]
        var minIndex = 0
        for (index,point) in enumerate(points) {
            (minIndex,minYPoint) = point.position.y < minYPoint.position.y ? (index,point) : (minIndex,minYPoint)
        }
        points.removeAtIndex(minIndex)
        points.sort {
            return calculatePolarAngle(minYPoint.position, $0.position) < calculatePolarAngle(minYPoint.position, $1.position)
        }
        var stack = [minYPoint]
        var restPoints = [PointView]()
        stack.append(points[0])
        stack.append(points[1])
        for point in points[2..<points.count] {
            while checkPoint(stack.last!.position, inTriangle: (stack[0].position,stack[stack.count-2].position,point.position)) {
                stack.last?.isConvexHullNode = false
                restPoints.append(stack.last!)
//                println(stack.last!)
                stack.removeLast()
                if stack.count < 3 {
                    break
                }
            }
            stack.append(point)
        }
        points = stack + restPoints
        endTime = NSDate()
    }
    
}
