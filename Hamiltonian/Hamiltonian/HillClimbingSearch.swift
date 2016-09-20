//
//  HillClimbingSearch.swift
//  Hamiltonian
//
//  Created by 杨萧玉 on 14/12/16.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class HillClimbingSearch: BaseTreeSearching {
    override init(){
        super.init()
        preprocessor = { ()->Bool in
            self.points.sort(by: { (a, b) -> Bool in
                return a.neighbours.count < b.neighbours.count
            })
            return true
        }
    }
    override func backtracking(_ points: [PointView], neighbour: PointView) {
        sortedPoints.append(neighbour)
        neighbour.image = NSImage(named: "RedPoint")
        let sortedSet = sortedPoints.last!.neighbours.sortedArray(using: [NSSortDescriptor(key: "neighbours", ascending: true, comparator: { (a, b) -> ComparisonResult in
            if (a as! NSMutableSet).count < (b as! NSMutableSet).count {
                return .orderedAscending
            }
            else if (a as! NSMutableSet).count > (b as! NSMutableSet).count{
                return .orderedDescending
            }
            else{
                return .orderedSame
            }
        })])
        if (sortedSet as? [PointView] != nil){
            for point in sortedSet {
                if (point as AnyObject).position == sortedPoints[0].position {
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
        }
        if !success {
            sortedPoints.last!.image = NSImage(named: "point")
            sortedPoints.removeLast()
        }
    }
}
