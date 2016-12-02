//
//  day18.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day18: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day18.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        return "\(getNumberOfLightsOn(input, atStep: 100))"
    }
    
    func partTwo() -> String {
        return "\(getNumberOfLightsOn(input, atStep: 100, cornersStuckOn: true))"
    }
    
    func testCode() -> String {
        let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day18_test.txt", encoding: NSUTF8StringEncoding)
        
        return "\(getNumberOfLightsOn(testInput, atStep: 5, cornersStuckOn: true))"
    }
    
    func getNumberOfLightsOn(input: String, atStep step: Int, cornersStuckOn: Bool = false) -> Int{
        let rows = input.componentsSeparatedByString("\n")
        let column = input.componentsSeparatedByString("\n")[0].characters
        
        assert( rows.count == column.count, "rows != columns!")
        
        let matrix = Matrix(rows: rows.count, columns: column.count, cornersStuckOn: cornersStuckOn)
        for i in 0..<matrix.rows {
            let startIndex = rows[i].characters.startIndex
            for j in 0..<matrix.columns {
                let nextIndex = startIndex.advancedBy(j)
                if (cornersStuckOn && (i == 0 && j == 0 || i == 0 && j == matrix.columns - 1 ||
                j == 0 && i == matrix.rows-1 || i == matrix.rows-1 && j == matrix.columns - 1)) {
                    matrix[i,j] = true
                    continue
                }
                
                matrix[i, j] = rows[i].characters[nextIndex] == "#" ? true : false
            }
        }
        
        return matrix.getStep(withNumber: step).getNumberOn()
    }
    
    class Matrix : CustomStringConvertible {
        let rows: Int, columns: Int
        let cornersStuckOn: Bool
        var grid: [Bool]
        
        init(rows: Int, columns: Int, cornersStuckOn: Bool = false) {
            self.rows = rows
            self.columns = columns
            self.cornersStuckOn = cornersStuckOn
            grid = Array(count: rows*columns, repeatedValue: false)
        }
        
        var description: String {
            var printableGrid: String = ""
            
            for i in 0..<rows {
                for j in 0..<columns {
                    printableGrid += "\(self[i,j] ? "#" : ".") "
                }
                printableGrid += "\n"
            }
            
            return "\(printableGrid)"
        }
        
        func getNumberOn() -> Int {
            return grid.filter({ $0 == true} ).count
        }
        
        func indexIsValidForRow(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        
        func getCellNeighboursState(row: Int, column:Int) -> [Bool] {
            var neighbours: [Bool] = []
            
            for i in row-1...row+1 {
                for j in column-1...column+1 {
                    if i == row && j == column { continue } // self
                    neighbours.append(self[i, j])
                }
            }
            
            return neighbours
        }
        
        func getStep(withNumber number: Int) -> Matrix{
            var step = self
            for _ in 0..<number {
                step = step.getNextStep()
            }
            
            return step
        }
        
        func getNextStep() -> Matrix {
            let nextStep: Matrix = Matrix(rows: self.rows, columns: self.columns, cornersStuckOn: self.cornersStuckOn)
            for i in 0..<self.rows {
                for j in 0..<self.columns {
                    
                    if (cornersStuckOn && (i == 0 && j == 0 || i == 0 && j == self.columns - 1 ||
                        j == 0 && i == self.rows-1 || i == self.rows-1 && j == self.columns - 1)) {
                            nextStep[i,j] = true
                            continue
                    }
                    
                    let numNeighboursOn = getCellNeighboursState(i, column: j).filter( { $0 == true }).count
                    let curStep = self[i,j]
                    var newStep = false
                    
                    if(curStep == true && (numNeighboursOn == 2 || numNeighboursOn == 3)) {
                        newStep = true
                    } else if (curStep == false && numNeighboursOn == 3) {
                        newStep = true
                    }
                    
                    nextStep[i,j] = newStep
                }
            }
            
            return nextStep
        }
        
        subscript(row: Int, column: Int) -> Bool {
            get {
                if !indexIsValidForRow(row, column: column) { return false }
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValidForRow(row, column: column), "Index out of range!")
                grid[(row * columns) + column] = newValue
            }
        }
    }
}