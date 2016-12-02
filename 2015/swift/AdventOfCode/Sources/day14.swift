//
//  day14.swift
//  AdventOfCode
//
//  Created by Matthew on 24/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day14: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/advent-of-code/AdventOfCode/AdventOfCode/Input/day14.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        let reindeerArray = input.componentsSeparatedByString("\n")
        var reindeers: [Reindeer] = []
        
        for reindeer in reindeerArray {
            let vals = (reindeer =~  "\\d+").items
            reindeers.append(Reindeer(name: "", speed: Int(vals[0])!, flightTime: Int(vals[1])!, restTime: Int(vals[2])!))
        }
        
        let maxDistance = reindeers.maxElement({ (reindeer01, reindeer02) -> Bool in
            return reindeer01.distanceTravelled(2503) < reindeer02.distanceTravelled(2503)
        })?.distanceTravelled(2503)
        
        return "\(maxDistance!)"
    }
    
    func partTwo() -> String {
        let reindeerArray = input.componentsSeparatedByString("\n")
        var reindeers: [Reindeer] = []
        
        for reindeer in reindeerArray {
            let vals = (reindeer =~  "\\d+").items
            reindeers.append(Reindeer(name: "", speed: Int(vals[0])!, flightTime: Int(vals[1])!, restTime: Int(vals[2])!))
        }
        
        //sort reindeers based on distance
        for i in 1...2503 {
            let max = reindeers.sort( { $0.distanceTravelled(i) < $1.distanceTravelled(i) } ).last!.distanceTravelled(i)
            reindeers.filter({$0.distanceTravelled(i)==max}).forEach({$0.awardPoint()})
        }
        
        let winningReindeer = reindeers.maxElement({ (reindeer01, reindeer02) -> Bool in
            return reindeer01.points < reindeer02.points
        })
        
        return "\(winningReindeer?.points)"
    }
    
    func testCode() -> String {
        let test01 = "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds."
        let test02 = "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds."
        
        var testStr: String = ""
        testStr += "Time: 1s - Comet: \(Reindeer(fromFile: test01).distanceTravelled(1)), Dancer: \(Reindeer(fromFile: test02).distanceTravelled(1)) \n"
        testStr += "Time: 11s - Comet: \(Reindeer(fromFile: test01).distanceTravelled(11)), Dancer: \(Reindeer(fromFile: test02).distanceTravelled(11)) \n"
        testStr += "Time: 12s - Comet: \(Reindeer(fromFile: test01).distanceTravelled(12)), Dancer: \(Reindeer(fromFile: test02).distanceTravelled(12)) \n"
        testStr += "Time: 1000s - Comet: \(Reindeer(fromFile: test01).distanceTravelled(1000)), Dancer: \(Reindeer(fromFile: test02).distanceTravelled(1000))"
        
        return testStr
    }
    
    class Reindeer {
        var name: String
        var speed: Int
        var flightTime: Int
        var restTime: Int
        var points = 0
        
        init(name: String, speed: Int, flightTime: Int, restTime: Int) {
            self.name = name
            self.speed = speed
            self.flightTime = flightTime
            self.restTime = restTime
        }
        
        convenience init(fromFile str : String) {
            let vals = (str =~  "\\d+").items
            self.init(name: "", speed: Int(vals[0])!, flightTime: Int(vals[1])!, restTime: Int(vals[2])!)
        }
        
        func distanceTravelled(time: Int) -> Int {
            
            var counter = 0
            var distance = 0
            repeat {
                let modTime = counter % (self.flightTime + self.restTime)
                if(modTime < self.flightTime ) {
                    distance += self.speed
                }
                counter++
            } while ( counter <= time )
            
            return distance
        }
        
        func awardPoint() {
            points++
        }
    }
}