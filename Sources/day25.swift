//
//  day25.swift
//  AdventOfCode
//
//  Created by Matthew on 29/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day25: Day {
    
    //Input (row, column)
    var testInput = Coordinate(row: 4, column: 2)
    var input = Coordinate(row: 2947, column: 3029)
    
    func partOne() -> String {
        let rule = { (pos: Int) -> Int in
            var val = 20151125
            var count = 1
            
            while(count < pos) {
                val = (val * 252533) % 33554393
                count++
            }
            
            return val
        }
        
        return "\(codeAt(getPosition(input), rule: rule))"
    }
    
    func partTwo() -> String {
        return ""
    }
    
    func testCode() -> String {
        let rule = { (pos: Int) -> Int in return pos }
        return "\(codeAt(getPosition(Coordinate(row: 4, column: 3)), rule: rule))"
    }
    
    func codeAt(pos: Int, rule: (Int) -> Int ) -> Int {
        return rule(pos)
    }

    func getPosition(pos: Coordinate) -> Int {
        let triangleRow = (pos.row + pos.column-1)
        
        var upToPos = 0
        var i = triangleRow - 1
        while(i > 0) {
            upToPos += i
            i--
        }
        
        return (upToPos + pos.column)
    }
}

struct Coordinate {
    var row = 0, column = 0
}
