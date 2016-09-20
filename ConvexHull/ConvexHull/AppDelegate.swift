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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func selectAlgorithm(_ sender: NSMenuItem) {
        switch sender.title {
        case "蛮力法":
            chooseDelegate?.algorithmSelected = .bruteForceCH
        case "GrahamScan":
            chooseDelegate?.algorithmSelected = .grahamScan
        case "DivideAndConquer":
            chooseDelegate?.algorithmSelected = .divideAndConquer
        default:
            chooseDelegate?.algorithmSelected = .grahamScan
        }
    }
    
    @IBAction func selectPointSum(_ sender: NSMenuItem) {
        switch sender.title {
        case "0":
            chooseDelegate?.pointNumSelected = 0
        case "1000":
            chooseDelegate?.pointNumSelected = 1000
        case "2000":
            chooseDelegate?.pointNumSelected = 2000
        case "3000":
            chooseDelegate?.pointNumSelected = 3000
        case let x:
            if let num = Int(x) {
                chooseDelegate?.pointNumSelected = UInt32(num)
            }
        }
    }
    

}

