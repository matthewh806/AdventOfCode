//
//  main.swift
//  AdventOfCode
//
//  Created by Matthew on 16/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

if( Process.arguments.count != 2) {
    print("AdventOfCode [0-25]")
} else {
    switch Process.arguments[1] {
    case "1", "01":
        print("Day01: PartOne: \(Day01().partOne()), PartTwo \(Day01().partTwo())")
        break
    case "2", "02":
        print("Day02: TestCode: \(Day02().testCode())")
        print("Day02: PartOne: \(Day02().partOne()), PartTwo \(Day02().partTwo())")
        break
    case "3", "03":
        print("Day03: TestCode: \(Day03().testCode())")
        print("Day03: PartOne: \(Day03().partOne()), PartTwo \(Day03().partTwo())")
        break
    case "4", "04":
        print("Day04: TestCode: \(Day04().testCode())")
        print("Day04: PartOne: \(Day04().partOne()), PartTwo \(Day04().partTwo())")
        break
    case "5", "05":
        print("Day05: TestCode: \(Day05().testCode())")
        print("Day05: PartOne: \(Day05().partOne()), PartTwo \(Day05().partTwo())")
        break
    case "6", "06":
        print("Day06: TestCode: \(Day06().testCode())")
        print("Day06: PartOne: \(Day06().partOne()), PartTwo \(Day06().partTwo())")
        break
    case "7", "07":
        break
    case "8", "08":
        print("Day08: TestCode: \(Day08().testCode())")
        print("Day08: PartOne: \(Day08().partOne()), PartTwo \(Day08().partTwo())")
        break
    case "9", "09":
        print("Day09: TestCode: \(Day09().testCode())")
        print("Day09: PartOne: \(Day09().partOne()), PartTwo \(Day09().partTwo())")
        break
    case "10":
        print("Day10: TestCode: \(Day10().testCode())")
        print("Day10: PartOne: \(Day10().partOne()), PartTwo \(Day10().partTwo())")
        break
    case "11":
        print("Day11: PartOne: \(Day11().partOne()), PartTwo \(Day11().partTwo())")
        break
    case "12":
        print("Day12: TestCode: \(Day12().testCode())")
        print("Day12: PartOne: \(Day12().partOne()), PartTwo \(Day12().partTwo())")
        break
    case "13":
        break
    case "14":
        print("Day14: TestCode: \(Day14().testCode())")
        print("Day14: PartOne: \(Day14().partOne()), PartTwo \(Day14().partTwo())")
        break
    case "15":
        print("Day15: TestCode: \(Day15().testCode())")
        print("Day15: PartOne: \(Day15().partOne()), PartTwo \(Day15().partTwo())")
        break
    case "16":
        print("Day16: TestCode: \(Day16().testCode())")
        print("Day16: PartOne: \(Day16().partOne()), PartTwo \(Day16().partTwo())")
        break
    case "17":
        print("Day17: TestCode: \(Day17().testCode())")
        print("Day17: PartOne: \(Day17().partOne()), PartTwo \(Day17().partTwo())")
        break
    case "18":
        print("Day18: TestCode: \(Day18().testCode())")
        print("Day18: PartOne: \(Day18().partOne()), PartTwo \(Day18().partTwo())")
        break
    case "19":
        print("Day19: TestCode: \(Day19().testCode())")
        print("Day18: PartOne: \(Day19().partOne()), PartTwo \(Day19().partTwo())")
        break
    case "20":
        print("Day20: TestCode: \(Day20().testCode())")
        print("Day20: PartOne: \(Day20().partOne()), PartTwo \(Day20().partTwo())")
        break
    case "21":
        print("Day21: TestCode: \(Day21().testCode())")
        print("Day21: PartOne: \(Day21().partOne()), PartTwo \(Day21().partTwo())")
        break
    case "22":
        break
    case "23":
        //print("Day23: TestCode: \(Day23().testCode())")
        //print("Day23: PartOne: \(Day23().partOne()), PartTwo \(Day23().partTwo())")
        break
    case "24":
        break
    case "25":
        print("Day25: TestCode: \(Day25().testCode())")
        print("Day25: PartOne: \(Day25().partOne()), PartTwo \(Day25().partTwo())")
        break
    default:
        print("Invalid arg for day, please enter a value between 0-25")
    }
}