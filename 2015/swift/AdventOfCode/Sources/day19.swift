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
        //let strings = input.componentsSeparatedByString("\n").map({ $0.componentsSeparatedByString(" => ") })
        //let replacements = strings.filter({$0.count == 2})
        //let startingMolecule = strings.last![0]
        
        //var foundMatch = false
        
        return ""
        //return "\(fastestMoleculeFabricationChains(startingMolecule, replacements: replacements, foundMatch: &foundMatch)[0].count-1)"
    }
    
    func testCode() -> String {
        let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day19_test.txt", encoding: NSUTF8StringEncoding)
        
        let strings = testInput.componentsSeparatedByString("\n").map({ $0.componentsSeparatedByString(" => ") })
        let replacements = strings.filter({$0.count == 2})
        let startingMolecule = strings.last![0]
        
        var foundMatch = false
        //print("\(fastestMoleculeFabricationChains(startingMolecule, replacements: replacements, foundMatch: &foundMatch)[0])")
        return "\(fastestMoleculeFabricationChains(startingMolecule, replacements: replacements, foundMatch: &foundMatch)[0].count-1)"
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
                        let range = calibrationMolecule.rangeFromNSRange(match.rangeAtIndex(i))!
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
    
//    func countElementsInMolecule(molecule: String) -> Int {
//        var counter = 0
//        molecule.characters.forEach({
//            let str = String($0)
//            if str.uppercaseString != str { counter++ }
//        })
//        
//        return counter
//    }
    
    //Reverse engineer approach...
    func fastestMoleculeFabricationChains(startingMolecule: String, replacements: [[String]], inout foundMatch: Bool) -> [[String]] {
        if(foundMatch) { return [] }
        if(startingMolecule == "e") {
            foundMatch = true
            return [[startingMolecule]]
        }
        
        var previousStrings: [[String]] = []
        for replacement in replacements {
            do {
                let regex = try NSRegularExpression(pattern: replacement[1], options: []);
                let matches = regex.matchesInString(startingMolecule, options: [], range: NSMakeRange(0, startingMolecule.characters.count))
                for match in matches {
                    for i in 0..<match.numberOfRanges {
                        let range = startingMolecule.rangeFromNSRange(match.rangeAtIndex(i))!
                        let newString = startingMolecule.stringByReplacingCharactersInRange(range, withString: replacement[0])
                        let backChains = fastestMoleculeFabricationChains(newString, replacements: replacements, foundMatch: &foundMatch)
                        
                        previousStrings += backChains.map({
                            var newArray = $0
                            newArray.append(startingMolecule)
                            return newArray
                        })
                    }
                }
            } catch {
                print("Regex was bad!")
                return[]
            }
        }
        
        return previousStrings
    }
}