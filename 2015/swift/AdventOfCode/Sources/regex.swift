//
//  regex.swift
//  AdventOfCode
//
//  Created by Matthew on 19/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation


infix operator =~ {}

func =~ (value: String, pattern: String) -> RegexMatchResult {
    let nsstr = value as NSString
    let options : NSRegularExpressionOptions = []
    
    do {
        let re = try NSRegularExpression(pattern: pattern, options: options)
        let all = NSRange(location: 0, length: nsstr.length)
        var matches: Array<String> = []
        re.enumerateMatchesInString(value, options: [], range: all) { (result, flags, ptr) -> Void in
            guard let result = result else { return }
            let string = nsstr.substringWithRange(result.range)
            matches.append(string)
        }
        
        return RegexMatchResult(items: matches)
    } catch {
        return RegexMatchResult(items: [])
    }
}

struct RegexCaptureGenerator : GeneratorType {
    var items: ArraySlice<String>
    mutating func next() -> String? {
        if items.isEmpty { return nil }
        let ret = items[items.startIndex]
        items = items[1..<items.count]
        return ret
    }
}

struct RegexMatchResult : SequenceType, BooleanType {
    var items: Array<String>
    func generate() -> RegexCaptureGenerator {
        return RegexCaptureGenerator(items: items[0..<items.count])
    }
    var boolValue: Bool {
        return items.count > 0
    }
    
    subscript(i: Int) -> String {
        return items[i]
    }
}