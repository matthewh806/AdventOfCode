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
        break
    case "3", "03":
        break
    case "4", "04":
        break
    case "5", "05":
        break
    case "6", "06":
        break
    case "7", "07":
        break
    case "8", "08":
        break
    case "9", "09":
        break
    case "10":
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
        break
    case "17":
        print("Day17: TestCode: \(Day17().testCode())")
        print("Day17: PartOne: \(Day17().partOne()), PartTwo \(Day17().partTwo())")
        break
    case "18":
        break
    case "19":
        break
    case "20":
        print("Day20: TestCode: \(Day20().testCode())")
        print("Day20: PartOne: \(Day20().partOne()), PartTwo \(Day20().partTwo())")
        break
    case "21":
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