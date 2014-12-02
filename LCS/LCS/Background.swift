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
    
    
    var mode = 0;
    var lcs = LCS()
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        switch mode{
        case 0:
            result.stringValue = lcs.simpleLCS(sequenceA.stringValue, y: sequenceB.stringValue)
        case 1:
            result.stringValue = lcs.calculateLCS(sequenceA.stringValue, y: sequenceB.stringValue)
        default:
            result.stringValue = lcs.simpleLCS(sequenceA.stringValue, y: sequenceB.stringValue)
        }
        
    }
    
    @IBAction func radioButtonclicked(sender:NSMatrix){
        switch (sender.selectedCell() as NSButtonCell).title {
        case "分治技术":
            mode = 0
        case "动态规划":
            mode = 1
        default:
            mode = 0
        }
    }
    
}
