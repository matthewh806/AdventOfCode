//
//  main.swift
//  AdventOfCode//
//  Created by Matthew on 10/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day08: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day08.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        return parseInstructions(input, part: DayPart.ONE)
    }
    
    func partTwo() -> String {
        return parseInstructions(input, part: DayPart.TWO)

    }
    
    func testCode() -> String {
        return ""
    }
    
    func parseInstructions(instructionString: String, part: DayPart) -> String{
        let instructionArray = instructionString.componentsSeparatedByString("\n");
        
        if(part == DayPart.ONE) {
            var totalNumCharsInMemory = 0
            var totalNumCharsStrCode = 0
            for instruction in instructionArray {
                totalNumCharsInMemory += countNumCharsInMemory(instruction)
                totalNumCharsStrCode += countNumCharsOfStringCode(instruction)
            }
            
            return "TotalNumCharsStrCode \(totalNumCharsStrCode), totalNumCharsInMemory \(totalNumCharsInMemory), diff \(totalNumCharsStrCode - totalNumCharsInMemory)"
        } else {
            var totalNumOriginalRep = 0
            var totalNewlyEncodedString = 0
            
            for instruction in instructionArray {
                totalNumOriginalRep += countNumCharsOfStringCode(instruction)
                totalNewlyEncodedString += countNewlyEncodedString(instruction)
            }
            
            return "TotalNumOriginalRep \(totalNumOriginalRep), TotalNewlyEncodedString \(totalNewlyEncodedString), diff \(totalNewlyEncodedString - totalNumOriginalRep)"
        }
    }
    
    func countNumCharsOfStringCode(str: String) -> Int {
        //literally count the number of characters on the line...
        return str.characters.count
    }
    
    func countNewlyEncodedString(str: String) -> Int {
        let pattern = "\\\\[\\\\\\\"]|\\\\x.."
        let replace = { (match: String) -> String in
            if match == "\\\"" { return "\\\\\\\"" }
            else if match == "\\\\" { return "\\\\\\\\" }
            else { return "\\" + match}
        }
        
        var s = replaceStrings(str, pattern: pattern, replace: replace)
        
        s = replaceStrings(s, pattern: "^\"|\"$") {_ in
            return "\\\""
        }
        
        s = "\"\(s)\""
        return s.characters.count
    }
    
    func countNumCharsInMemory(str: String) -> Int {
        //BEWARE OF \xij hexadecimal representation in string e.g.(\x27 -> \u{27} in swift)
        //Also need to strip away quotes
        
        //First replace the hexadecimal notation
        let pattern = "\\\\[\\\\\\\"]|\\\\x.."
        let replace = { (match: String) -> String in
            if match == "\\\"" { return "\"" }
            else if match == "\\\\" { return "\\" }
            else {
                let char = match.substringWithRange(Range<String.Index>(start: match.startIndex.advancedBy(2), end: match.endIndex))
                let num = Int(strtoul(char, nil, 16))
                return String(UnicodeScalar(num))
            }
        }
        
        var s = replaceStrings(str, pattern: pattern, replace: replace)
        s = replaceStrings(s, pattern: "^\"|\"$") {_ in
            return ""
        }
        
        return s.characters.count
    }
    
    func replaceStrings(str: String, pattern: String, replace: (String) -> (String)) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
            var offset = 0
            var mStr = str
            for result in matches {
                var resultRange = result.range
                resultRange.location += offset
                
                let match = regex.replacementStringForResult(result, inString: mStr, offset: offset, template: "$0")
                let replacement = replace(match)
                mStr.replaceRange(
                    mStr.startIndex.advancedBy(resultRange.location)
                        ..< mStr.startIndex.advancedBy(resultRange.location + resultRange.length),
                    with: replacement
                )
                
                offset += (replacement.characters.count - resultRange.length)
            }
            
            return mStr
        } catch {
            print(error)
            return ""
        }
    }
    
    func convertHexNotationToSwift() -> String{
        return ""
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