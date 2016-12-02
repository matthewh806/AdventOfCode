//
//  day09.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day09: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day09.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        let pathExtremes = findExtremePath((parseInstructions(instructions: input)))
        return "PathMin:  \(pathExtremes.min), PathMax: \(pathExtremes.max)"
    }
    
    func partTwo() -> String {
        return ""
    }
    
    func testCode() -> String {
        return ""
    }
    
    func parseInstructions(instructions str: String) -> [Distance] {
        // Format: LocX to LocY = Distance
        let instructionArray = str.componentsSeparatedByString("\n")
        
        var distanceArray: [Distance] = []
        for instruction in instructionArray {
            //print(instruction)
            let strElements = instruction.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            let dist = Distance(locA: strElements[0], locB: strElements[2], distance: Int(strElements[4])!)
            
            distanceArray.append(dist)
        }
        
        return distanceArray
    }
    
    func findExtremePath(distances: [Distance]) -> (min: Int, max:Int) {
        
        let uniqueCities = getUniqueCities(distances)
        var minDistance = Int.max
        var maxDistance = Int.min
        
        for city in uniqueCities {
            var paths: [[Distance]] = []
            
            let visitedCities: [String] = [city]
            getPossiblePaths(city, cities: uniqueCities, visitedCities: visitedCities, paths: &paths, distances: distances)
            
            for path in paths {
                let pathDistance = getTotalPathDistance(path)
                if pathDistance < minDistance {
                    minDistance = pathDistance
                }
                if pathDistance > maxDistance {
                    maxDistance = pathDistance
                }
            }
        }
        
        return (minDistance, maxDistance)
    }
    
    func getPossiblePaths(curCity: String, cities: [String], visitedCities: [String], inout paths: [[Distance]], distances: [Distance]) {
        if(visitedCities.count == cities.count) {
            var path: [Distance] = []
            for(var i = 0; i<=(visitedCities.count-2); i++) {
                let city = visitedCities[i]
                let nextCity = visitedCities[i+1]
                for dist in distances {
                    if(dist.locA == city && dist.locB == nextCity || dist.locA == nextCity && dist.locB == city) {
                        path.append(dist)
                    }
                }
            }
            paths.append(path)
        } else {
            for city in cities {
                if(city != curCity && !visitedCities.contains(city)) {
                    var mutVC = visitedCities
                    mutVC.append(city)
                    
                    getPossiblePaths(city, cities: cities, visitedCities: mutVC, paths: &paths, distances: distances)
                }
            }
        }
    }
    
    func getTotalPathDistance(path: [Distance]) -> Int{
        var pathDistance = 0
        
        for p in path {
            pathDistance += p.distance
        }
        
        return pathDistance
    }
    
    func getDistance(cityA: String, cityB: String, distances: [Distance]) -> Int {
        for dist in distances {
            if(dist.locA == cityA && dist.locB == cityB || dist.locB == cityA && dist.locA == cityB) {
                return dist.distance
            }
        }
        
        print("ERROR: PATH NOT FOUND")
        return -1
    }
    
    func getUniqueCities(distances: [Distance]) -> [String] {
        var cities: [String] = []
        
        for dist in distances {
            if !cities.contains(dist.locA) {
                cities.append(dist.locA)
            }
            if !cities.contains(dist.locB) {
                cities.append(dist.locB)
            }
        }
        
        return cities
    }
    
    struct Distance : CustomStringConvertible{
        var locA: String
        var locB: String
        var distance: Int
        
        var description: String {
            return "\(locA) -> \(locB), dist: \(distance)"
        }
    }


}
