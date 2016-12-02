//
//  day24.swift
//  AdventOfCode
//
//  Created by Matthew on 12/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day24 : Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day24.txt", encoding: NSUTF8StringEncoding)
    let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day24_test.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        let packages = input.componentsSeparatedByString("\n").map( { Int($0) ?? 0} ).sort( {$0 > $1} )
        let idealConfigurations = findIdealConfigurations(3, packages: packages)
        
        return "\(findSmallestQuantumEntanglement(idealConfigurations))"
    }
    
    func partTwo() -> String {
        let packages = input.componentsSeparatedByString("\n").map( { Int($0) ?? 0} ).sort( {$0 > $1} )
        let idealConfigurations = findIdealConfigurations(4, packages: packages)
        
        return "\(findSmallestQuantumEntanglement(idealConfigurations))"

    }
    
    func testCode() -> String {
        let packages = testInput.componentsSeparatedByString("\n").map( { Int($0) ?? 0} ).sort( {$0 > $1} )
        let idealConfigurations = findIdealConfigurations(4, packages: packages)
        
        return "\(findSmallestQuantumEntanglement(idealConfigurations))"
    }
    
    func findSmallestQuantumEntanglement(packages: [Set<Int>]) -> Int {
        return packages.map({ $0.reduce(1, combine: *) }).minElement()!
    }
    
    func findIdealConfigurations(numGroups: Int, packages: [Int]) -> [Set<Int>] {
        let groupWeight = packages.reduce(0, combine: +) / numGroups
        var arrangements = findNumbersWhichSumTo(groupWeight, startIndex: 0, numbers: packages, set: [])
        
        while(arrangements.count > 0) {
            var idealArrangements:[Set<Int>] = []
            let smallestGroupSize = arrangements.minElement( { $0.count < $1.count})!.count
            let smallestGroups = arrangements
                .filter({ $0.count == smallestGroupSize })
            
            for group in smallestGroups {
                if(arrangements.filter( { $0.isDisjointWith(group) }).count > 0) {
                    idealArrangements.append(group)
                }
            }
            
            if( idealArrangements.count > 0) {
                return idealArrangements
            } else {
                arrangements = arrangements.filter({ $0.count == smallestGroupSize })
            }
        }
        
        return []

    }
    
    func findNumbersWhichSumTo(target: Int, startIndex: Int, numbers: [Int], set: Set<Int>) -> [Set<Int>] {
        //Requires a sorted array!!
        if(target == 0) { return [set] }
        
        var index = startIndex
        var sets: [Set<Int>] = []
        while(index < numbers.count && numbers[index] > target) {
            //too big
            index++
        }
        while(index < numbers.count && numbers[index] <= target) {
            //loop until end of array or overshoot target
            var newSet = set
            newSet.insert(numbers[index])
            sets += findNumbersWhichSumTo(target-numbers[index], startIndex: index+1, numbers: numbers, set: newSet)
            index++
        }
        
        return sets
    }
}