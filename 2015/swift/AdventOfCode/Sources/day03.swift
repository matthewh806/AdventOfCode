//
//  day03.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day03: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day03.txt", encoding: NSUTF8StringEncoding)
    func partOne() -> String {
        return "\(countHousesVisited(moveSanta(input, roboSanta:false)))"
    }
    func partTwo() -> String {
        return "\(countHousesVisited(moveSanta(input, roboSanta:true)))"
    }
    func testCode() -> String {
        //print(countHousesVisited(moveSanta(">", roboSanta:false)))
        //print(countHousesVisited(moveSanta("^>v<", roboSanta:false)))
        //print(countHousesVisited(moveSanta("^v^v^v^v^v", roboSanta:false)))
        return "\(countHousesVisited(moveSanta("^v^v^v^v^v", roboSanta:false)))"
    }
    
    func moveSanta(dirStr: String, roboSanta: Bool) -> [point]{
        var points: [point] = []
        let startingPos = point(x: 0, y:0)
        points.append(startingPos)
        
        for chracter in dirStr.characters {
            var newPos: point
            if let curPos = (points.count > 1 && roboSanta) ? points[points.count-2   ] : points.last {
                if chracter == "^" {
                    //North
                    newPos = point(x:curPos.x, y:curPos.y+1)
                } else if chracter == ">" {
                    //East
                    newPos = point(x:curPos.x+1, y:curPos.y)
                } else if chracter == "v" {
                    //South
                    newPos = point(x:curPos.x, y:curPos.y-1)
                } else if chracter == "<" {
                    //West
                    newPos = point(x:curPos.x-1, y:curPos.y)
                } else {
                    continue
                }
                
                points.append(newPos)
            } else {
                print("Array not initialized!")
            }
        }
        
        return points
    }
    
    func countHousesVisited(points: [point]) -> Int{
        var housesVisited = 0
        var pointsVisited: [point] = []
        
        for point in points {
            //Check points array -> if house not in visited points array, incremented housesVisted + add to visited
            if pointsVisited.contains(point) {
                continue
            }
            
            housesVisited++
            pointsVisited.append(point)
        }
        
        return housesVisited
    }

}

public struct point {
    let x: Int
    let y: Int
}

extension point:Equatable {}
public func ==(lhs: point, rhs: point) -> Bool {
    return ( lhs.x == rhs.x && lhs.y == rhs.y )
}