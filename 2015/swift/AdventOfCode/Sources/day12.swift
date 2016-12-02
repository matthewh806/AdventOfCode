//
//  day12.swift
//  AdventOfCode
//
//  Created by Matthew on 20/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day12: Day {
    
    let jsonString = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day12.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        //return "\(sumDigits(jsonString))"
        return ""
    }
    
    func partTwo() -> String {
        //return ""
        return "\(sumDigits(jsonString, skipRed: true))"
    }
    
    func testCode() -> String {
        let testStrings1 = ["[1,2,3]", "{\"a\":2,\"b\":4}", "[[[3]]]", "{\"a\":{\"b\":4},\"c\":-1}", "{\"a\":[-1,1]}", "[-1,{\"a\":1}]", "[]", "{}"]
        let testStrings2 = ["[1,2,3]", "[1,{\"c\":\"red\",\"b\":2},3]", "{\"d\":\"red\",\"e\":[1,2,3,4],\"f\":5}", "[1,\"red\",5]",
                            "{\"e\":171,\"a\":{\"e\":\"green\",\"c\":49,\"a\":\"orange\",\"g\":22,\"b\":\"violet\",\"d\":\"orange\",\"f\":\"orange\"},\"d\":\"red\",\"c\":113,\"h\":\"green\",\"b\":[30,\"blue\"],\"g\":{\"a\":139,\"b\":47},\"f\":\"red\",\"i\":\"red\"}", "{\"a\":139,\"b\":47},\"i\":\"red}"]
        var rtnStrPart1 = ""
        var rtnStrPart2 = ""
        for testString in testStrings1 {
            rtnStrPart1 += "\(sumDigits(testString))\n"
        }
        for testString in testStrings2 {
            rtnStrPart2 += "\(sumDigits(testString, skipRed: true))\n"
        }
        
        return "Part1: \(rtnStrPart1) \nPart2: \(rtnStrPart2)"
    }
    
    func sumDigits(str: String, skipRed: Bool = false) -> String {
        var mutableStr = str
        
        if(skipRed) {
            repeat {
                let regex = try! NSRegularExpression(pattern: "\\{[^\\{]*:\"red\"[^\\}]*\\}", options: NSRegularExpressionOptions.CaseInsensitive)
                let strRange: Range<String.Index> = mutableStr.startIndex..<mutableStr.endIndex
                mutableStr = regex.stringByReplacingMatchesInString(mutableStr, options: [], range: mutableStr.NSRangeFromRange(strRange), withTemplate: "")
            } while((mutableStr =~ "\\{[^\\{]*:\"red\"[^\\}]*\\}").items.count > 0)
            //print(mutableStr)
        }
        return "\((mutableStr =~ "(\\-?\\d+)").items.map{ Int($0) ?? 0 }.reduce(0) { $0 + $1})"
    }
}