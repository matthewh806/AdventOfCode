//
//  day13.swift
//  AdventOfCode
//
//  Created by Matthew on 09/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//


import Foundation

class Day13: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day13.txt", encoding: NSUTF8StringEncoding)
    let testInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/TestInput/day13_test.txt", encoding: NSUTF8StringEncoding)

    func partOne() -> String {
        return "\(getOptimalSeatingArrangement(getAttendees(input)))"
    }
    
    func partTwo() -> String {
        return "\(getOptimalSeatingArrangement(getAttendees(input), includeSelf: true))"
    }
    
    func testCode() -> String {
        return "\(getOptimalSeatingArrangement(getAttendees(testInput)))"
    }
    
    func getOptimalSeatingArrangement(attendees: [String: [String:Int]], includeSelf: Bool = false) -> Int{
        var attendeeNames = Array(attendees.keys)
        if(includeSelf) { attendeeNames.append("[me]") }
        
        let optimalArrangement = getAllPermutations(attendeeNames).maxElement({ getTotalChangeInHappiness($0, attendees: attendees) < getTotalChangeInHappiness($1, attendees: attendees)})
        
        return getTotalChangeInHappiness(optimalArrangement!, attendees: attendees)
    }
    
    func getAllPermutations<T>(locations: [T]) -> [[T]] {
        if locations.count == 1 { return [locations] }
        
        var allResults: [[T]] = []
        for (i, loc) in locations.enumerate() {
            var locs = locations // mutable
            locs.removeAtIndex(i)
            
            let permutations = getAllPermutations(locs)
            let p = permutations.map({ (a: [T]) -> [T] in
                var b = a //mutable
                b.insert(loc, atIndex: 0)
                return b
            })
            
            allResults += p
        }
        
        return allResults
    }
    
    func getTotalChangeInHappiness(arrangement: [String], attendees: [String: [String:Int]]) -> Int {
        
        let count = arrangement.count
        var changeInHappiness = 0
        for (index, attendee) in arrangement.enumerate() {
            let nextAttendee = arrangement[index + 1 > count-1 ? 0 : index + 1]
            
            changeInHappiness += getChangeInHappinessBetween(attendee, attendee2: nextAttendee, attendees: attendees)
        }
        
        return changeInHappiness
    }
    
    func getChangeInHappinessBetween(attendee1: String, attendee2: String, attendees: [String:[String:Int]]) -> Int {
        guard let attendeeOneRelations = attendees[attendee1] else { return 0 }
        guard let attendeeTwoRelations = attendees[attendee2] else { return 0 }
        guard let attendeeOneChange = attendeeOneRelations[attendee2] else { return 0 }
        guard let attendeeTwoChange = attendeeTwoRelations[attendee1] else { return 0 }
        
        return attendeeOneChange + attendeeTwoChange
    }
    
    func getAttendees(guestList: String) -> [String : [String:Int]] {
        var attendees: [ String : [String: Int] ] = [:]
        
        let attendeeStrings = guestList.componentsSeparatedByString("\n")
        let pattern = "(\\w+) would (\\w+) (\\d+) happiness units by sitting next to (\\w+)."
        
        for attendee in attendeeStrings {
            do {
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let matches = regex.matchesInString(attendee, options: [], range: NSMakeRange(0, attendee.characters.count))
                
                for match in matches {
                    var a : [String] = []
                    // e.g. Alice, gain, 54, Bob
                    for i in 1..<match.numberOfRanges {
                        let range = attendee.rangeFromNSRange(match.rangeAtIndex(i))
                        a.append(attendee.substringWithRange(range!))
                    }
                    let deltaHappiness = a[1] == "gain" ? Int(a[2])! : -1 * Int(a[2])!
                    
                    var dict = attendees[a[0]] ?? [:]
                    dict[a[3]] = deltaHappiness
                    attendees[a[0]] = dict
                }
                
            } catch {
                print("Bad regex!")
                return [:]
            }
        }
        
        return attendees
    }
}