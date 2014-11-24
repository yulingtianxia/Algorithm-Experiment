//
//  BruteForceCH.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class BruteForceCH: NSObject,ConvexHullGenerator {
    
    func generateConvexHull(var points:[CGPoint]) -> [CGPoint] {
        
        func calculatePoint(pointP:CGPoint,onLine line:(pointA:CGPoint,pointB:CGPoint)) -> CGFloat {
            return (pointP.y - line.pointA.y) * (line.pointB.x - line.pointA.x) - (line.pointB.y - line.pointA.y) * (pointP.x - line.pointA.x)
        }
        
        func checkPoint(P:CGPoint,inTriangle triangle:(A:CGPoint,B:CGPoint,C:CGPoint)) -> Bool {
            let AB = calculatePoint(P, onLine: (triangle.A,triangle.B)) * calculatePoint(triangle.C, onLine: (triangle.A,triangle.B)) >= 0
            let AC = calculatePoint(P, onLine: (triangle.A,triangle.C)) * calculatePoint(triangle.B, onLine: (triangle.A,triangle.C)) >= 0
            let BC = calculatePoint(P, onLine: (triangle.C,triangle.B)) * calculatePoint(triangle.A, onLine: (triangle.C,triangle.B)) >= 0
            return AB && AC && BC
        }
        
        if points.count <= 3 {
            return points
        }
        
        pointLoop: for var index = 0; index < points.count; ++index {
            var point1 = points[index]
            for point2 in points {
                if point2 == point1 {
                    continue
                }
                for point3 in points {
                    if point3 == point1 || point3 == point2 {
                        continue
                    }
                    for point4 in points {
                        if point4 == point1 || point4 == point2 || point4 == point3 {
                            continue
                        }
                        if checkPoint(point1, inTriangle: (point2,point3,point4)) {
                            points.removeAtIndex(index--)
                            continue pointLoop
                        }
                    }
                }
            }
        }
        
        var minXPoint = points[0]
        var maxXPoint = points[0]
        for point in points {
            minXPoint = point.x < minXPoint.x ? point : minXPoint
            maxXPoint = point.x > maxXPoint.x ? point : maxXPoint
        }
        var su = points.filter {
            calculatePoint($0, onLine: (minXPoint,maxXPoint)) > 0
        }
        var sl = points.filter {
            calculatePoint($0, onLine: (minXPoint,maxXPoint)) < 0
        }
        su = su.sorted {
            return ($0 as CGPoint).x > ($1 as CGPoint).x
        }
        sl = sl.sorted {
            return ($0 as CGPoint).x < ($1 as CGPoint).x
        }
        var result = [minXPoint]
        result += sl
        result.append(maxXPoint)
        result += su
        return result
    }
    
    
}
