//
//  day17.swift
//  AdventOfCode
//
//  Created by Matthew on 30/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day17: Day {
     let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day17.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        return "\(fillContainers(150, containers: input.componentsSeparatedByString("\n").map({ Int($0)! })).count)"
    }
    
    func partTwo() -> String {
        let containerArray = fillContainers(150, containers: input.componentsSeparatedByString("\n").map({ Int($0)! }))
        let minContainers = containerArray.minElement( { $0.count < $1.count})
        return "\(containerArray.filter({$0.count == minContainers!.count}).count)"
    }
    
    func testCode() -> String {
        //let minLengthEl = fillContainers(25, containers: [20, 15, 10, 5, 5]).minElement( { $0.count < $1.count} )
        //print(fillContainers(25, containers: [20, 15, 10, 5, 5]).filter({ $0.count == minLengthEl!.count}).count)
        return "\(fillContainers(25, containers: [20, 15, 10, 5, 5]).count)"
    }
    
    func fillContainers(litres: Int, containers: [Int]) -> [[Int]] {
        if(litres < 0) { return [] }
        if containers.count == 1 {
            if containers[0] == litres { return [containers] } else { return [] }
        }
        
        var combinations: [[Int]] = []
        for (index, container) in containers.enumerate() {
            if(container == litres) {
                combinations += [[container]]
            } else if ( container < litres) {
                let reducedContainers = Array(containers[index+1 ..< containers.count])
                let newCombinations: [[Int]] = (fillContainers(litres-container, containers: reducedContainers))
                if( newCombinations.count > 0 ) {
                    combinations += newCombinations.map({
                        var newArray = $0
                        newArray.append(container)
                        return newArray
                    })
                }
            }
        }
        return combinations
    }
}