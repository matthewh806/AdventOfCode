//
//  day05.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day05: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day05.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        var numOfNiceStringsPt1: Int {
            
            var num = 0
            for inputString in input.componentsSeparatedByString("\n") {
                if(isStringNice(inputString, part: DayPart.ONE)) {
                    num++;
                }
            }
            
            return num
        }
        
        return "\(numOfNiceStringsPt1)"
    }
    
    func partTwo() -> String {
        var numOfNiceStringsPt2: Int {
            var num = 0
            for inputString in input.componentsSeparatedByString("\n") {
                if(isStringNice(inputString, part: DayPart.TWO)) {
                    num++;
                }
            }
            
            return num
        }

        return "\(numOfNiceStringsPt2)"
    }
    
    func testCode() -> String {
        //var testStrings02 = ["qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy"];

        return ""
    }
    
    func isStringNice(testStr: String, part: DayPart) -> Bool{
        //endIndex is position after final character
        let endIndex = testStr.characters.endIndex;
        
        if(part == DayPart.ONE)
        {
            var containsIllegalStr = false
            var twiceInRow = false
            var numVowels = 0
            
            for index in testStr.characters.indices {
                //test for illegal strings first
                let character = testStr[index];
                
                if(index.successor() < endIndex) {
                    let nextCharacter = testStr[index.successor()];
                    
                    if(character == "a" && nextCharacter == "b") { containsIllegalStr = true; }
                    if(character == "c" && nextCharacter == "d") { containsIllegalStr = true; }
                    if(character == "p" && nextCharacter == "q") { containsIllegalStr = true; }
                    if(character == "x" && nextCharacter == "y") { containsIllegalStr = true; }
                    
                    if(character == nextCharacter) { twiceInRow = true; }
                }
                
                if(["a", "e", "i", "o", "u"].contains(character)) { numVowels++ }
            }
            
            if(!containsIllegalStr && twiceInRow && numVowels >= 3) {
                return true;
            }
            
            return false;
        } else {
            var repeatingPair = false;
            var repeatingLetters = false;
            var occurancesOfString = 0
            
            for index in testStr.characters.indices {
                let character = testStr[index];
                
                if(index != endIndex && index.advancedBy(1) < endIndex && index.advancedBy(2) < endIndex) {
                    if(character == testStr[index.advancedBy(2)]) {
                        repeatingLetters = true;
                    }
                }
                
                if(index.successor() < endIndex) {
                    let pairString = "\(character)\(testStr[index.successor()])"
                    let pairRange = Range<String.Index>(start: index, end: index.advancedBy(2));
                    
                    //Check if this string occurs more than once in the overal string without overlap
                    for index2 in testStr.characters.indices {
                        if(index2.successor() < endIndex) {
                            let secondPairString = "\(testStr[index2])\(testStr[index2.successor()])"
                            let secondPairRange = Range<String.Index>(start: index2, end: index2.advancedBy(2));
                            
                            if(pairString == secondPairString) {
                                
                                //Check for overlaps...
                                if( pairRange.startIndex >= secondPairRange.endIndex || pairRange.endIndex <= secondPairRange.startIndex) {
                                    occurancesOfString++;
                                }
                            }
                        }
                    }
                    
                    if occurancesOfString > 1 {
                        repeatingPair = true;
                    }
                }
            }
            
            if(repeatingPair && repeatingLetters) {
                print("\(testStr): nice!");
                return true;
            }
            
            print("\(testStr): naughty!");
            return false;
        }
    }

}