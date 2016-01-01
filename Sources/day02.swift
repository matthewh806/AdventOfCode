//
//  day02.swift
//  AdventOfCode
//
//  Created by Matthew on 01/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day02 : Day {
    
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day02.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        return "Amount of wrappingPaperRequired \(calcRequiredValues().0)"
    }
    
    func partTwo() -> String {
        return "Length of ribbon required \(calcRequiredValues().1)!"
    }
    
    func testCode() -> String {
//        let testPresent01 = present.init(presentBox: box.init(length: 2, width: 3, height: 4))
//        let testPresent02 = present.init(presentBox: box.init(length: 1, width: 1, height: 10))
//        let testPresent03 = present.init(presentBox: box.init(length: 10, width: 20, height: 5))
        
        return ""
    }
    
   
    
    func parseInput(fileName: String) -> [box]? {
        let dimensionsArray = input.componentsSeparatedByString("\n")
        
        var boxes: [box] = []
        for dimensions in dimensionsArray {
            boxes.append(box.init(dimensionsStr: dimensions))
        }
        
        return boxes
    }
    
    func calcRequiredValues() -> (Float, Float) {
        let boxes = parseInput(input)
        
        var totalSqrFt: Float = 0
        var totalRibbonFt: Float = 0
        if let validBoxes = boxes {
            for box in validBoxes {
                let elfPresent = present.init(presentBox: box)
                totalSqrFt += elfPresent.wrappingPaperRequired
                totalRibbonFt += elfPresent.ribbonRequired
            }
        }
        
        return (totalSqrFt, totalRibbonFt)
    }
}

public struct box {
    let length: Float
    let width: Float
    let height: Float
    
    public init(length: Float, width: Float, height: Float) {
        self.length = length
        self.width = width
        self.height = height
    }
    
    public init(dimensionsStr: String) {
        let dimensionArray = dimensionsStr.componentsSeparatedByString("x")
        
        if(dimensionArray.count != 3) {
            self.length = 0
            self.width = 0
            self.height = 0
            
            return
        }
        
        self.length = NSNumberFormatter().numberFromString(dimensionArray[0])!.floatValue
        self.width = NSNumberFormatter().numberFromString(dimensionArray[1])!.floatValue
        self.height = NSNumberFormatter().numberFromString(dimensionArray[2])!.floatValue
    }
    
    var surfaceArea: Float {
        return 2 * length * width + 2 * width * height + 2 * height * length
    }
    
    var volume: Float {
        return length * width * height
    }
    
    func smallestSideArea() -> Float {
        let areaLW = length * width
        let areaWH = width * height
        let areaHL = height * length
        
        return min(areaLW, areaWH, areaHL)
    }
    
    func smallestFacePerimeter() -> Float {
        let faceLW = 2*(length + width)
        let faceWH = 2*(width + height)
        let faceHL = 2*(height + length)
        
        return min(faceLW, faceWH, faceHL)
    }
}

public struct present {
    let presentBox: box
    
    public init(presentBox: box) {
        self.presentBox = presentBox
    }
    
    var wrappingPaperRequired: Float {
        return presentBox.surfaceArea + presentBox.smallestSideArea()
    }
    
    var ribbonRequired: Float {
        return presentBox.volume + presentBox.smallestFacePerimeter()
    }
}
    