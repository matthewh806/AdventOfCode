//
//  day16.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day16: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day16.txt", encoding: NSUTF8StringEncoding)
    
    let targetSue: [String: Int] = [ "children": 3, "cats": 7, "samoyeds": 2, "pomeranians": 3, "akitas":0, "vizslas":0, "goldfish":5, "trees": 3, "cars":2, "perfumes": 1]
    
    func partOne() -> String {
        return "\(findTargetSue(input, target: targetSue, part: DayPart.ONE))"
    }
    
    func partTwo() -> String {
        return "\(findTargetSue(input, target: targetSue, part: DayPart.TWO))"
    }
    
    func testCode() -> String {
        //return "\(findTargetSue(input, target: ["children": 1]))"
        //return "\(findTargetSue(input, target: ["children": 1, "cars": 8]))"
        return "\(findTargetSue("Sue 323: perfumes: 1, trees: 6, goldfish: 0", target: targetSue, part: DayPart.TWO))"
    }
    
    func findTargetSue(input: String, target: [String:Int], part: DayPart) -> Int {
        let sues = input.componentsSeparatedByString("\n").map({ ($0 =~ "\\w+\\s?\\d+|\\w+:\\s?\\d+").items })
        
        for sue in sues {
            var targetSue = true
            for property in sue {
                if( property =~ "\\w+:\\s?\\d+") {
                    let testkv = property.componentsSeparatedByString(":").map({ $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())})
                    
                    if part == DayPart.ONE {
                        if !target.contains( { $0.0 == testkv[0] && $0.1 == Int(testkv[1])! } ) { targetSue = false; break }
                    } else {
                        switch testkv[0] {
                            case "cats", "trees":
                                if !target.contains( { $0.0 == testkv[0] && $0.1 < Int(testkv[1])! } ) { targetSue = false; break }
                            case "pomeranians", "goldfish":
                                if !target.contains( { $0.0 == testkv[0] && $0.1 > Int(testkv[1])! } ) { targetSue = false; break }
                            default:
                                if !target.contains( { $0.0 == testkv[0] && $0.1 == Int(testkv[1])! } ) { targetSue = false; break }
                        }
                    }
                }
            }
            
            if(targetSue) { return(Int((sue[0] =~ "\\d+")[0])!) }
        }
        
        return -1
    }
    
    
}