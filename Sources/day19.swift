//
//  day19.swift
//  AdventOfCode
//
//  Created by Matthew on 02/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day19: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day19.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        return "Number of DistinctMolecules: \(calibrateMachineForInput(input).count)"
    }
    
    func partTwo() -> String {
        return ""
    }
    
    func testCode() -> String {
        let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day19_test.txt", encoding: NSUTF8StringEncoding)
        
        return "Number of DistinctMolecules: \(calibrateMachineForInput(testInput).count)"
    }
    
    func calibrateMachineForInput(input: String) -> [String] {
        let strings = input.componentsSeparatedByString("\n").map({ $0.componentsSeparatedByString(" => ") })
        let replacements = strings.filter({$0.count == 2})
        let calibrationMolecule = strings.last![0]

        var genMolecules: [String] = []
        for replacement in replacements {
            do {
                let regex = try NSRegularExpression(pattern: replacement[0], options: []);
                let matches = regex.matchesInString(calibrationMolecule, options: [], range: NSMakeRange(0, calibrationMolecule.characters.count))
                
                for match in matches {
                    for i in 0..<match.numberOfRanges {
                        let range = rangeFromNSRange(match.rangeAtIndex(i), forString: calibrationMolecule)!
                        genMolecules.append(calibrationMolecule.stringByReplacingCharactersInRange(range, withString: replacement[1]))
                    }
                }
                
            } catch {
                print("Regex was bad!")
                return []
            }
        }
        
        return Array(Set(genMolecules))
    }
    
    func rangeFromNSRange(nsRange: NSRange, forString str: String) -> Range<String.Index>? {
        let fromUTF16 = str.utf16.startIndex.advancedBy(nsRange.location, limit: str.utf16.endIndex)
        let toUTF16 = fromUTF16.advancedBy(nsRange.length, limit: str.utf16.endIndex)
        
        if let from = String.Index(fromUTF16, within: str),
            let to = String.Index(toUTF16, within: str) {
                return from ..< to
        }
        
        return nil
    }
}