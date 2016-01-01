//
//  main.swift
//  day-04
//
//  Created by Matthew on 07/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day04: Day {
    let input = "yzbqklnj"
    let testInput01 = "abcdef"
    let testInput02 = "pqrstuv"
    
    func partOne() -> String {
        //return "\(findMd5HashWithLeadingZeros(input, leadingZeros: 5))"
        return "See Python implementation"
    }
    
    func partTwo() -> String {
        //return "\(findMd5HashWithLeadingZeros(input, leadingZeros: 5))"
        return "See Python implementation"
    }
    
    func testCode() -> String {
        return ""
    }
    
//    func findMd5HashWithLeadingZeros(partialStr: String, leadingZeros: Int = 5) {
//        let prefix = Array<String>(count: leadingZeros, repeatedValue: "0").joinWithSeparator("")
//        
//        var number = 0
//        while(true) {
//            if "\(partialStr)\(number)".md5.hasPrefix(prefix) {
//                print(number)
//                return
//            }
//            number += 1
//        }
//    }
}

//extension String  {
//    var md5: String! {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        
//        result.dealloc(digestLen)
//        
//        return String(format: hash as String)
//    }
//}



