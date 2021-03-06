//
//  BruteForceCH.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class BruteForceCH: NSObject,ConvexHullGenerator {
    var beginTime = Date(timeIntervalSince1970: 0)
    var endTime = Date(timeIntervalSince1970: 0)
    var costTime:TimeInterval {
        get{
           return endTime.timeIntervalSince(beginTime)
        }
    }
    func generateConvexHull(_ points:inout [PointView]){
        beginTime = Date()
        for point in points {
            point.isConvexHullNode = true
        }
        
        if points.count <= 3 {
            return
        }
        
        var minXPoint = points[0]
        var maxXPoint = points[0]
        for point in points {
            minXPoint = point.position.x < minXPoint.position.x ? point : minXPoint
            maxXPoint = point.position.x > maxXPoint.position.x ? point : maxXPoint
        }
        
        let point1 = minXPoint;
        for point2 in points {
            if !point2.isConvexHullNode || point2 == point1 {
                continue
            }
            for point3 in points {
                if !point3.isConvexHullNode || point3 == point1 || point3 == point2 {
                    continue
                }
                for point4 in points {
                    if !point4.isConvexHullNode || point4 == point1 || point4 == point2 || point4 == point3 {
                        continue
                    }
                    if checkPoint(point4.position, inTriangle: (point2.position,point3.position,point1.position)) {
                        point4.isConvexHullNode = false
                        continue
                    }
                }
            }
        }
        
        var su = points.filter {
            calculatePoint($0.position, onLine: (minXPoint.position,maxXPoint.position)) > 0
        }
        var sl = points.filter {
            calculatePoint($0.position, onLine: (minXPoint.position,maxXPoint.position)) < 0
        }
        su = su.sorted {
            return ($0.position as CGPoint).x > ($1.position as CGPoint).x
        }
        sl = sl.sorted {
            return ($0.position as CGPoint).x < ($1.position as CGPoint).x
        }
        var result = [minXPoint]
        result += sl
        result.append(maxXPoint)
        result += su
        points = result
        endTime = Date()
    }
    
}
