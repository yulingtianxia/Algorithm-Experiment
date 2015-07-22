//
//  LCS.swift
//  LCS
//
//  Created by 杨萧玉 on 14/12/2.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

import Cocoa


class LCS: NSObject {
    var C = [[Int]]()
    var B = [[Int]]()
    var result:String = ""
    
    func calculateLCS(x:String,y:String) -> String{
        result = ""
        let m = x.characters.count
        let n = y.characters.count
        C = [[Int]](count:m+1,repeatedValue:[Int](count:n+1,repeatedValue:0))
        B = [[Int]](count:m+1,repeatedValue:[Int](count:n+1,repeatedValue:0))
        for (i,charx) in x.characters.enumerate() {
            for (j,chary) in y.characters.enumerate() {
                if charx==chary {
                    C[i+1][j+1] = C[i][j] + 1
                    B[i+1][j+1] = 1
                }
                else if C[i][j+1]>=C[i+1][j]{
                    C[i+1][j+1] = C[i][j+1]
                    B[i+1][j+1] = 2
                }
                else {
                    C[i+1][j+1] = C[i+1][j]
                    B[i+1][j+1] = 3
                }
            }
        }
        var chars = [Character]()
        for char in x.characters {
            chars.append(char)
        }
        
        printLCS(chars, i: m, j: n)
        return result
    }
    
    private func printLCS(x:[Character],i:Int,j:Int) {
        if i==0||j==0 {
            return
        }
        if B[i][j]==1 {
            printLCS(x, i: i-1, j: j-1)
//            let range = Range(start: i, end: i)
            result.append(x[i-1])
        }
        else if B[i][j]==2 {
            printLCS(x, i: i-1, j: j)
        }
        else {
            printLCS(x, i: i, j: j-1)
        }
    }
    
    func simpleLCS(x:String,y:String)->String{
        let m = x.characters.count
        let n = y.characters.count
        if m==0||n==0 {
            return ""
        }
        var charsX = [Character]()
        var charsY = [Character]()
        for char in x.characters {
            charsX.append(char)
        }
        for char in y.characters {
            charsY.append(char)
        }
        if charsX[m-1]==charsY[n-1] {
            var result = simpleLCS(x.substringToIndex(x.endIndex.predecessor()), y: y.substringToIndex(y.endIndex.predecessor()))
            result.append(charsX[m-1])
            return result
        }
        else {
            let z1 = simpleLCS(x.substringToIndex(x.endIndex.predecessor()), y: y)
            let z2 = simpleLCS(x, y: y.substringToIndex(y.endIndex.predecessor()))
            return z1.characters.count > z2.characters.count ? z1 : z2
        }
    }
}
