//
//  day10.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day10: Day {
    let testInput = [[1], [1,1], [2,1], [1,2,1,1], [1,1,1,2,2,1]]
    let input = [1,1,1,3,1,2,2,1,1,3]
    
    func partOne() -> String {
        return "\(print(iterateSequence(input, numTimes: 40).count))"
    }
    
    func partTwo() -> String {
        return "\(print(iterateSequence(input, numTimes: 50).count))"
    }
    
    func testCode() -> String {
        return ""
    }
    
    func lookAndSay(input: [Int]) -> [Int]{
        var index:Int = 0
        var newSequence: [Int] = []
        
        while(index < input.count) {
            var secondIndex = index+1
            
            let elAtIndex = input[index]
            var consecutiveInts = 1
            
            while(secondIndex < input.count && input[secondIndex] == elAtIndex) {
                consecutiveInts++
                secondIndex++
            }
            
            newSequence.append(consecutiveInts)
            newSequence.append(elAtIndex)
            index += consecutiveInts
        }
        
        return newSequence
    }
    
    func iterateSequence(input: [Int], numTimes: Int) -> [Int]{
        var counter = 0
        var mutableSeq = input
        
        while(counter < numTimes) {
            mutableSeq = lookAndSay(mutableSeq)
            counter++
        }
        
        return mutableSeq
    }
}