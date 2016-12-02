//
//  day.swift
//  AdventOfCode
//
//  Created by Matthew on 16/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

protocol Day {
    func partOne() -> String
    func partTwo() -> String
    func testCode() -> String
}

enum DayPart {
    case ONE
    case TWO
}