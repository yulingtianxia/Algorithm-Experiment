//
//  BaseTreeSearching.swift
//  Hamiltonian
//
//  Created by 杨萧玉 on 14/12/12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class BaseTreeSearching: NSObject,HamiltonianGenerator {
    var beginTime:Date = Date()
    var endTime:Date = Date()
    var costTime:TimeInterval {
        get{
            return endTime.timeIntervalSince(beginTime)
        }
    }
    var sortedPoints:[PointView] = []
    var success = false
    var points:[PointView]!
    var preprocessor:()->Bool = {return true}
    func generateHamiltonian(_ points:inout [PointView])->[PointView] {
        self.points = points
        beginTime = Date()
        success = false
        sortedPoints.removeAll(keepingCapacity: false)
        if preprocessor() {
            if points.count>0 {
                backtracking(points, neighbour: points[0])
            }
        }
        endTime = Date()
        return sortedPoints
    }
    
    func backtracking(_ points:[PointView],neighbour:PointView) {
        sortedPoints.append(neighbour)
        neighbour.image = NSImage(named: "RedPoint")
        for point in sortedPoints.last!.neighbours {
            if (point as! PointView).position == sortedPoints[0].position {
                if sortedPoints.count == points.count {
                    success = true
                    return
                }
                else {
                    continue
                }
            }
            else if checkPoint(point as! PointView, inPoints: sortedPoints) {
                continue
            }
            else {
                backtracking(points, neighbour: point as! PointView)
            }
        }
        if !success {
            sortedPoints.last!.image = NSImage(named: "point")
            sortedPoints.removeLast()
        }
    }
    
    func checkPoint(_ aPoint:PointView,inPoints points:[PointView])->Bool {
        for point in points {
            if point.position == aPoint.position {
                return true;
            }
        }
        return false
    }
}
