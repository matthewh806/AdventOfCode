//
//  String+NSrangeFromRange.swift
//  AdventOfCode
//
//  Created by Matthew on 17/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

extension String {    
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
}
