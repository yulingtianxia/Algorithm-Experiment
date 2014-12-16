//
//  MySearching.swift
//  Hamiltonian
//
//  Created by 杨萧玉 on 14/12/14.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class MySearching: BaseTreeSearching {
    override init(){
        super.init()
        preprocessor = { ()->Bool in
            for point in self.points {
                if point.neighbours.count <= 1 {
                    return false
                }
            }
            return true
        }
    }
}
