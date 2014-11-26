//
//  AppDelegate.swift
//  ConvexHull
//
//  Created by 杨萧玉 on 14/11/24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var chooseDelegate:ChooseAlgorithm?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func selectAlgorithm(sender: NSMenuItem) {
        switch sender.title {
        case "蛮力法":
            chooseDelegate?.algorithmSelected = .BruteForceCH
        case "GrahamScan":
            chooseDelegate?.algorithmSelected = .GrahamScan
        case "DivideAndConquer":
            chooseDelegate?.algorithmSelected = .DivideAndConquer
        default:
            chooseDelegate?.algorithmSelected = .GrahamScan
        }
    }

}

