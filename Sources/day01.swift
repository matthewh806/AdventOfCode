//
//  day01.swift
//  AdventOfCode
//
//  Created by Matthew on 16/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day01 : Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/advent-of-code/AdventOfCode/AdventOfCode/Input/day01.txt", encoding: NSUTF8StringEncoding)
    
    func countFloors(str: String) -> Int {
        var floor = 0
        
        for character in str.characters {
            if character == "(" {
                floor++
            } else if character == ")" {
                floor--
            }
        }
        
        return floor
    }
    
    //Note first char has posn 1
    func firstBasementPosition(str: String) -> Int {
        var floor = 0
        
        var index = 1
        for character in str.characters {
            if character == "(" {
                floor++
            } else if character == ")" {
                floor--
            }
            
            if floor == -1 {
                return index
            }
            
            index++
        }
        
        return -1
    }
    
    func printFloor(str: String) {
        print("\(str) gives floor: \(countFloors(str)), first basement pos: \(firstBasementPosition(str))")
    }
    
    func partOne() -> String {
        return "Floor: \(countFloors(input))"
    }
    
    func partTwo() -> String {
        return "Basement: \(firstBasementPosition(input))"
    }
    
    func testCode() -> String {
        return "Error: No test code"
    }

}