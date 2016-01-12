//
//  day07.swift
//  AdventOfCode
//
//  Created by Matthew on 11/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day07: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day07.txt", encoding: NSUTF8StringEncoding)
    let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day07_test.txt", encoding: NSUTF8StringEncoding)
    var wiresCache: [String:UInt16] = [:]
    
    func partOne() -> String {
        wiresCache = [:]
        return "\(getSignal("a", wires: getWires(input)))"
    }
    
    func partTwo() -> String {
        wiresCache = [:]
        
        //Modify input!
        var wires = getWires(input)
        let signal = getSignal("a", wires: wires)
        
        if let _ = wires["b"] {
            wiresCache = [:]
            wires["b"] = String(signal)
            return "\(getSignal("a", wires: wires))"
        }
        
        return "Error: wire not found!"
    }
    
    func testCode() -> String {
        wiresCache = [:]
        return "\(getSignal("m", wires: getWires(testInput)))"
    }
    
    func getSignal(wire: String, wires: [String:String]) -> UInt16 {
        // Look up wire in dictionary and find out which other wires need to be set before we can figure it out
        
        // Check if the value has already been cached to prevent further lookups...
        if let val = wiresCache[wire] {
            return val
        }
        
        guard let value = wires[wire] else { print("Error: Key \(wire) not found!"); return 0}
        let instructions = value.componentsSeparatedByString(" ")
        var signal: UInt16 = 0
        
        switch instructions.count {
        case 1:
            // found the signal!
            guard let val = UInt16(instructions[0]) else { return getSignal(instructions[0], wires: wires) }
            signal = val
        case 2:
            // NOT
            let val1 = UInt16(instructions[1]) ?? getSignal(instructions[1], wires: wires)
            
            if(instructions[0] == "NOT") {
                signal = ~val1
            }
        case 3:
            // Check for AND, OR, LSHIFT, RSHIFT
            let val1 = UInt16(instructions[0]) ?? getSignal(instructions[0], wires: wires)
            let val2 = UInt16(instructions[2]) ?? getSignal(instructions[2], wires: wires)
            
            if(instructions[1] == "AND") {
                signal = val1 & val2
            } else if(instructions[1] == "OR") {
                signal = val1 | val2
            } else if(instructions[1] == "LSHIFT") {
                signal = val1 << val2
            } else if(instructions[1] == "RSHIFT") {
                signal = val1 >> val2
            }

        default: signal = 0
        }
        
        if(wiresCache[wire] == nil) { wiresCache[wire] = signal }
        return signal
    }
    
    func getWires(Input: String) -> [String:String] {
        var wires: [String:String] = [:]
        
        let signals = Input.componentsSeparatedByString("\n")
        
        for signal in signals {
            var pairs = signal.componentsSeparatedByString(" -> ")
            wires[pairs[1]] = pairs[0]
        }
        return wires
    }
}