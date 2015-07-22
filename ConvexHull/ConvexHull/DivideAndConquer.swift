//
//  DivideAndConquer.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/25.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa
import AppKit


class DivideAndConquer: NSObject, ConvexHullGenerator {
    
    var restPoints = [PointView]()
    var beginTime = NSDate(timeIntervalSince1970: 0)
    var endTime = NSDate(timeIntervalSince1970: 0)
    var costTime:NSTimeInterval {
        get{
            return endTime.timeIntervalSinceDate(beginTime)
        }
    }
    func Conquer(inout points: [PointView]) {
//        println(points.count)
        if points.count < 3 {
            return
        }
        
        func midPoint(points:[PointView]) -> CGPoint? {
            if points.count == 1 {
                return nil
            }
            var minYPoint = points[0]
            var maxYPoint = points[0]
            
            for point in points {
                minYPoint = point.position.y < minYPoint.position.y ? point : minYPoint
                maxYPoint = point.position.y > maxYPoint.position.y ? point : maxYPoint
            }
            let midPoint = CGPoint(x:(minYPoint.position.x + maxYPoint.position.x)/2,y:(minYPoint.position.y + maxYPoint.position.y)/2)
            return midPoint
        }
        
        func counterclockwiseSort(inout points: [PointView],midPoint:CGPoint) {
            points.sortInPlace {
                return calculatePolarAngle(midPoint, target: $0.position) < calculatePolarAngle(midPoint, target: $1.position)
            }
        }
        
        if points.count == 3 {
            counterclockwiseSort(&points,midPoint: midPoint(points)!)
            return
        }
        
        var minXPoint = points[0]
        var maxXPoint = points[0]
        
        for point in points {
            minXPoint = point.position.x < minXPoint.position.x ? point : minXPoint
            maxXPoint = point.position.x > maxXPoint.position.x ? point : maxXPoint
//            println(point.position)
        }
        
        let divide = (minXPoint.position.x + maxXPoint.position.x)/2
        
        var left = points.filter {
            return $0.position.x <= divide
        }
        
        var right = points.filter {
            return $0.position.x > divide
        }
        if left.count>0 {
            Conquer(&left)
        }
        if right.count>0 {
            Conquer(&right)
        }
        
        var combine = left + right
        let middle = midPoint(left) ?? midPoint(right)
        //FIXME: combine
        counterclockwiseSort(&combine,midPoint: middle!)
        
//        for com in combine {
//            println(com.position)
//        }
        var stack = [PointView]()
        stack.append(combine[0])
        stack.append(combine[1])
        for point in combine[2..<combine.count] {
            while checkPoint(stack.last!.position, inTriangle: (middle!,stack[stack.count-2].position,point.position)) {
                stack.last?.isConvexHullNode = false
                restPoints.append(stack.last!)
                stack.removeLast()
                if stack.count < 2 {
                    break
                }
            }
            stack.append(point)
        }
        
        while stack.count >= 2 && checkPoint(stack.last!.position, inTriangle: (middle!,stack[stack.count-2].position,stack[0].position)) {
            stack.last?.isConvexHullNode = false
            restPoints.append(stack.last!)
            stack.removeLast()
            if stack.count < 2 {
                break
            }
            while stack.count >= 2 && checkPoint(stack[0].position, inTriangle: (middle!,stack.last!.position,stack[1].position)) {
                stack[0].isConvexHullNode = false
                restPoints.append(stack[0])
                stack.removeAtIndex(0)
                if stack.count < 2 {
                    break
                }
            }
        }
        
        while stack.count >= 2 && checkPoint(stack[0].position, inTriangle: (middle!,stack.last!.position,stack[1].position)) {
            stack[0].isConvexHullNode = false
            restPoints.append(stack[0])
            stack.removeAtIndex(0)
            if stack.count < 2 {
                break
            }
        }
        
        points = stack
    }
    
    func generateConvexHull(inout points: [PointView]) {
        beginTime = NSDate()
        for point in points {
            point.isConvexHullNode = true
        }
        Conquer(&points)
        
        points += restPoints
        restPoints.removeAll(keepCapacity: false)
        
        func adjustSort(inout points:[PointView],count:Int) {
            for var index = 0; index<count; ++index {
                points.insert(points.last!, atIndex: 0)
                points.removeLast()
            }
        }
        endTime = NSDate()
    }
}
