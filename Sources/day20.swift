//
//  day20.swift
//  AdventOfCode
//
//  Created by Matthew on 31/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation
import Darwin

class Day20: Day {
    var input = 36000000
    
    func partOne() -> String {
        let targetNumPresents = 36000000
        var lowestHouseNo = Int.max
        
        for i in 1..<Int.max {
            if(getFactorsOf(i).reduce(0, combine: +) * 10 >= targetNumPresents) { lowestHouseNo = i; break }
        }
        
        return "Presents: \(targetNumPresents), lowest house no: \(lowestHouseNo)"
    }
    
    func partTwo() -> String {
        let targetNumPresents = 36000000
        var lowestHouseNo = Int.max
        
        for i in 1..<Int.max {
            if(getFactorsOf(i, limit: 50).reduce(0, combine: +) * 11 >= targetNumPresents) { lowestHouseNo = i; break }
        }
        
        return "Presents: \(targetNumPresents), lowest house no: \(lowestHouseNo)"
    }
    
    func testCode() -> String {
        let targetNumPresents = 130
        print(getFactorsOf(100, limit: 20))
        var lowestHouseNo = Int.max
        
        for i in 1..<Int.max {
            if(getFactorsOf(i).reduce(0, combine: +) * 10 >= targetNumPresents) { lowestHouseNo = i; break }
        }
        
        return "Presents: \(targetNumPresents), lowest house no: \(lowestHouseNo)"
    }
    
    func getFactorsOf(num: Int, limit: Int = 0) -> [Int] {
        var factors: Set<Int> = []
        
        for i in 1...sqrt(num) {
            if num % i == 0 {
                if limit == 0 || limit * i >= num { factors.insert(i) }
                if limit == 0 || limit * num/i >= num {factors.insert(num/i) }
            }
        }
        
        return factors.sort()
    }
    
    func sqrt(x: Int) -> Int { return Int(Darwin.sqrt(Double(x))) }

}