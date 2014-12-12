//
//  HelpMethod.swift
//  Hamiltonian
//
//  Created by 杨萧玉 on 14/12/12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

protocol HamiltonianGenerator{
    var beginTime:NSDate{get set}
    var endTime:NSDate{get set}
    var costTime:NSTimeInterval{get}
    func generateHamiltonian(inout points:[PointView])->[PointView]
}

protocol ChooseAlgorithm {
    var algorithmSelected:Algorithm {get set}
}

enum Algorithm {
    case BaseTreeSearch
    case HillClimbing
}

