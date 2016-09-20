//
//  Background.swift
//  LCS
//
//  Created by 杨萧玉 on 14/12/2.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa

class Background: NSView,NSTextFieldDelegate,NSMatrixDelegate {

    @IBOutlet weak var sequenceA: NSTextField!
    
    @IBOutlet weak var sequenceB: NSTextField!
    
    @IBOutlet weak var result: NSTextField!
    
    @IBOutlet weak var timeCost:NSTextField!
    
    var mode:Int = 0{
        didSet{
            run();
        }
    }
    var lcs = LCS()
    var beginTime = Date(timeIntervalSince1970: 0)
    var endTime = Date(timeIntervalSince1970: 0)
    var costTime:TimeInterval {
        get{
            return endTime.timeIntervalSince(beginTime)*1000
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        run();
    }
    
    func run(){
        beginTime = Date();
        switch mode{
        case 0:
            result.stringValue = lcs.simpleLCS(sequenceA.stringValue, y: sequenceB.stringValue)
        case 1:
            result.stringValue = lcs.calculateLCS(sequenceA.stringValue, y: sequenceB.stringValue)
        default:
            result.stringValue = lcs.simpleLCS(sequenceA.stringValue, y: sequenceB.stringValue)
        }
        endTime = Date();
        timeCost.stringValue = costTime.description
    }
    @IBAction func radioButtonclicked(_ sender:NSMatrix){
        switch (sender.selectedCell() as! NSButtonCell).title {
        case "分治技术":
            mode = 0
        case "动态规划":
            mode = 1
        default:
            mode = 0
        }
    }
    
}
