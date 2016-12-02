//
//  day23.swift
//  AdventOfCode
//
//  Created by Matthew on 31/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day23: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day23.txt", encoding: NSUTF8StringEncoding)
    let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day23_test.txt", encoding: NSUTF8StringEncoding)
    
    struct Register {
        var val = 0
        
        mutating func inc() { val++ }
        
        mutating func hlf() { val /= 2 }
        
        mutating func tpl() { val *= 3 }
    }
    
    func partOne() -> String {
        //return ""
        return parseInstructions(input.componentsSeparatedByString("\n"))
    }
    
    func partTwo() -> String {
        return parseInstructions(input.componentsSeparatedByString("\n"), part: DayPart.TWO)
    }
    
    func testCode() -> String {
        return parseInstructions(testInput.componentsSeparatedByString("\n"))
    }
    
    func parseInstructions(instructions: [String], part: DayPart = DayPart.ONE) -> String {
        var a = Register()
        var b = Register()
        
        if(part == DayPart.TWO) { a.inc() }
        
        var pos = 0
        repeat {
            let instruction = instructions[pos]
            
            if instruction.characters.contains("a") {
                pos = executeInstructionOnRegister(&a, pos: pos, instruction: instruction)
            } else if instruction.characters.contains("b") {
                pos = executeInstructionOnRegister(&b, pos: pos, instruction: instruction)
            } else {
                var dummy = Register()
                pos = executeInstructionOnRegister(&dummy, pos: pos, instruction: instruction)
            }
            
            //print("Value a: \(a.val), b: \(b.val)")
        } while ( pos < instructions.count )
        
        return "Value a: \(a.val), b: \(b.val)"
    }
    
    func executeInstructionOnRegister(inout register: Register, pos: Int, instruction: String) -> Int {
        if instruction.hasPrefix("hlf") {
            register.hlf()
            return pos + 1
        }
        
        if instruction.hasPrefix("tpl") {
            register.tpl()
            return pos + 1
        }
        
        if instruction.hasPrefix("inc") {
            register.inc()
            return pos + 1
        }
        
        if instruction.hasPrefix("jmp") {
            return pos + getOffset(instruction)
        }
        
        if instruction.hasPrefix("jie") {
            if register.val % 2 == 0 { return pos + getOffset(instruction) } else { return pos + 1 }
        }
        
        if instruction.hasPrefix("jio") {
            if register.val == 1 { return pos + getOffset(instruction) } else { return pos + 1 }
        }
        
        return 0
    }
    
    func getOffset(instruction: String) -> Int {
        let digits = (instruction =~ "(\\+|-)\\d+").items
        guard digits.count == 1 else { return 0 }
        return Int(digits[0]) ?? 0
    }
}