//
//  HelpMethod.swift
//  Hamiltonian
//
//  Created by 杨萧玉 on 14/12/12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

protocol HamiltonianGenerator: class{
    var beginTime:Date{get set}
    var endTime:Date{get set}
    var costTime:TimeInterval{get}
    func generateHamiltonian(_ points:inout [PointView])->[PointView]
}

protocol ChooseAlgorithm {
    var algorithmSelected:Algorithm {get set}
}

enum Algorithm {
    case baseTreeSearch
    case hillClimbing
    case mySearch
}

