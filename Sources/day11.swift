//
//  day11.swift
//  AdventOfCode
//
//  Created by Matthew on 19/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day11 : Day {
    
    let input = "hxbxwxba"
    let input2 = "hxbxxyzz"
    
    func partOne() -> String {
        return "oldPassword: \(input), newPassword: \(Password(str:input).findNextValidPassword().password)"
    }
    
    func partTwo() -> String {
        return "oldPassword: \(input2), newPassword: \(Password(str:input2).findNextValidPassword().password)"
    }
    
    func testCode() -> String {
        return "Error: No test code"
    }
    
    class Password {
        
        var password: String
        let alphabet: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
                                     "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        init(str: String) {
            password = str
        }
        
        func isValid() -> Bool {
            return hasIncreasingStraight() && hasNoIllegalCharacters() && hasAtLeastTwoNonOverlappingPairsOfLetters()
        }
        
        func hasIncreasingStraight() -> Bool {
            return (password =~ "(abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz)") ? true : false
        }
        
        func hasNoIllegalCharacters() -> Bool {
            return password.characters.indexOf("i") == nil && password.characters.indexOf("l") == nil && password.characters.indexOf("o") == nil
        }
        
        func hasAtLeastTwoNonOverlappingPairsOfLetters() -> Bool {
            return (password =~ "(\\w)\\1+").items.count > 1 ? true : false
        }
        
        func findNextValidPassword() -> Password {
            var mutablePass = password
            let endIndex = mutablePass.characters.endIndex
            var curIndex = endIndex.predecessor()
            
            repeat {
                let wrapped = incrementCharAtIndex(&mutablePass, indexInString: curIndex)
                if(wrapped) {
                    if(curIndex == mutablePass.characters.startIndex)
                    {
                        mutablePass = "No valid password!"
                        break
                    }
                    curIndex = curIndex.predecessor()
                } else {
                    curIndex = endIndex.predecessor()
                }
                //construct new password and check validity
                if(Password(str: mutablePass).isValid()) { break } /*else { print("Invalid: \(mutableInput)") }*/
            } while(true)
            
            return Password(str: mutablePass)
        }
        
        func incrementCharAtIndex(inout str: String, indexInString index: String.CharacterView.Index) -> Bool {
            var char = str[index]
            let curAlphabetIndex = alphabet.indexOf(char)
            let newAlphabetIndex = (curAlphabetIndex! + 1) % alphabet.count
            char = alphabet[newAlphabetIndex]
            str.replaceRange(index...index, with: String(char))
            
            //Check if the character wrapped around
            return (newAlphabetIndex == 0) ? true:false
        }
    }
}