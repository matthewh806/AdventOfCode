//
//  day06.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day06: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day06.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        let millionLightOnOffArray = LightArray(dimX: 1000, dimY: 1000)
        millionLightOnOffArray.parseInstructions(input, part: DayPart.ONE)
        return "\(millionLightOnOffArray.numLit)"
    }
    
    func partTwo() -> String {
        let millionLightBrightnessArray = LightArray(dimX: 1000, dimY: 1000)
        millionLightBrightnessArray.parseInstructions(input, part: DayPart.TWO)
        return "\(millionLightBrightnessArray.totalBrightness)"
    }
    
    func testCode() -> String {
        return ""
    }
    
    struct Instructions {
        static var Toggle = "toggle";
        static var TurnOn = "turn on";
        static var TurnOff = "turn off";
    }
    
    class LightArray : CustomStringConvertible {
        var lightArray = [[Int]]()
        var description: String {
            return "LightArray: \(lightArray)"
        }
        
        var numLit : Int {
            var num = 0
            for( var i = 0; i < lightArray.count; i++) {
                for( var j = 0; j < lightArray[i].count; j++) {
                    if( lightArray[i][j] == 1) {
                        num++
                    }
                }
            }
            return num
        }
        
        var totalBrightness: Int {
            var brightness = 0
            for( var i = 0; i < lightArray.count; i++) {
                for( var j = 0; j < lightArray[i].count; j++) {
                    brightness += lightArray[i][j]
                }
            }
            return brightness
        }
        
        init(dimX: Int, dimY: Int) {
            // Create 1000 x 1000 array
            for var i = 0; i < dimX; i++ {
                var subArray = [Int]()
                for var j = 0; j < dimY; j++ {
                    subArray.append(0);
                }
                lightArray.append(subArray)
            }
        }
        
        subscript(row: Int, column: Int) -> Int {
            get { return lightArray[row][column] }
            set { lightArray[row][column] = newValue }
        }
        
        func parseInstructions(instructionString: String, part: DayPart) {
            let instructionArray = instructionString.componentsSeparatedByString("\n");
            
            for instruction in instructionArray {
                if let(x1, y1, x2, y2) = getCoordinatesFromString(instruction) {
                    for var i = x1; i <= x2; i++ {
                        for var j = y1; j <= y2; j++ {
                            if instruction.hasPrefix(Instructions.TurnOff) {
                                part == DayPart.ONE ? turnOff(i, y: j) : turnDown(i, y: j)
                            } else if instruction.hasPrefix(Instructions.TurnOn) {
                                part == DayPart.ONE ? turnOn(i, y: j) : turnUp(i, y: j, inc: 1)
                            } else if instruction.hasPrefix(Instructions.Toggle) {
                                part == DayPart.ONE ? toggle(i, y: j) : turnUp(i, y: j, inc: 2)
                            } else {
                                print("Error: Not a valid instruction")
                            }
                        }
                    }
                }
            }
        }
        
        func turnOff(x: Int, y: Int) {
            lightArray[x][y] = 0
        }
        
        func turnOn(x: Int, y: Int) {
            lightArray[x][y] = 1
        }
        
        func toggle(x: Int, y: Int) {
            lightArray[x][y] = (lightArray[x][y] == 0) ? 1 : 0
        }
        
        func turnUp(x:Int, y:Int, inc: Int) {
            lightArray[x][y] += inc
        }
        
        func turnDown(x:Int, y: Int) {
            lightArray[x][y] -= (lightArray[x][y] > 0) ? 1 : 0
        }
        
        func getCoordinatesFromString(instructionString: String) -> (x1: Int, y1: Int, x2: Int, y2: Int)? {
            do {
                let regex = try NSRegularExpression(pattern: "([0-9]+),([0-9]+)", options: NSRegularExpressionOptions.CaseInsensitive);
                let matches = regex.matchesInString(instructionString, options: [], range: NSMakeRange(0, instructionString.characters.count));
                
                var (x1, y1, x2, y2) = (0,0,0,0);
                
                if let swiftRangeX1 = rangeFromNSRange(matches[0].rangeAtIndex(1), forString: instructionString) {
                    x1 = Int(instructionString.substringWithRange(swiftRangeX1))!
                }
                if let swiftRangeY1 = rangeFromNSRange(matches[0].rangeAtIndex(2), forString: instructionString) {
                    y1 = Int(instructionString.substringWithRange(swiftRangeY1))!
                }
                
                if let swiftRangeX2 = rangeFromNSRange(matches[1].rangeAtIndex(1), forString: instructionString) {
                    x2 = Int(instructionString.substringWithRange(swiftRangeX2))!
                }
                if let swiftRangeY2 = rangeFromNSRange(matches[1].rangeAtIndex(2), forString: instructionString) {
                    y2 = Int(instructionString.substringWithRange(swiftRangeY2))!
                }
                
                return (x1, y1, x2, y2)
                
            } catch {
                print("Regex was bad!")
                return nil
            }
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
}

