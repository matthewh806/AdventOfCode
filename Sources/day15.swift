//
//  day15.swift
//  AdventOfCode
//
//  Created by Matthew on 24/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day15: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/advent-of-code/AdventOfCode/AdventOfCode/Input/day15.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        var ingredients: [Ingredient] = []
        input.componentsSeparatedByString("\n").forEach({ ingredients.append(Ingredient(fromString: $0))})
        
        for ingredient in ingredients {
            print(ingredient.name)
        }
        
        return ""
    }
    
    func partTwo() -> String {
        return ""
    }
    
    func testCode() -> String {
        let butterscotch = Ingredient(fromString: "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8")
        let cinnamon = Ingredient(fromString: "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3")
        
        return "\(getBestRecipe([butterscotch, cinnamon]).totalScore)"
    }
    
    func getBestRecipe(ingredientsArray: [Ingredient]) -> Recipe {
        let numIngredients = ingredientsArray.count
        let numTeaspoons = 100
        let maxScore = 0
        
        //var ingredients: [Ingredient: Int] = [butterscotch: 0, cinnamon: 0]
        var ingredients: [Ingredient: Int] = [:]
        for ingredient in ingredientsArray {
            ingredients[ingredient] = 0
        }
        //ingredients.forEach({ print( $0.0.name ) })
        
        //Test all different combinations
        while(ingredients.reduce(0) {$0 + $1.1} < 100) {
            ingredients[(ingredients.first?.0)!]! += 1
        }
        
        return Recipe(ingredients: ingredients)
    }
    
    class Recipe {
        let MAX_INGREDIENTS = 100
        var ingredients: [Ingredient: Int]
        
        init(ingredients: [Ingredient: Int]) {
            self.ingredients = ingredients
        }
        
        var totalScore: Int {
            get {
                var capacity = 0, durability = 0, flavor = 0, texture = 0
                
                for (ingredient, quantity) in ingredients {
                    capacity += ingredient.capacity * quantity
                    durability += ingredient.durability * quantity
                    flavor += ingredient.flavor * quantity
                    texture += ingredient.texture * quantity
                }
                
                if(capacity < 0) { capacity = 0 }
                if(durability < 0) { durability = 0 }
                if(flavor < 0) { flavor = 0 }
                if(texture < 0) { texture = 0 }
                
                print("Capacity: \(capacity), Durability: \(durability), Flavor: \(flavor), Texture: \(texture)")
                return (capacity * durability * flavor * texture)
            }
        }
        
        func addIngredient(ingredient: Ingredient, teaspoons: Int) {
            if ingredients.count < MAX_INGREDIENTS {
                ingredients[ingredient] = teaspoons
            }
        }
    }

    class Ingredient : Hashable, Equatable {
        var name: String
        var capacity: Int
        var durability: Int
        var flavor: Int
        var texture: Int
        var calories: Int
        var hashValue: Int {
            return self.name.hashValue
        }
        
        init(name: String, capacity: Int, durability: Int, flavor: Int, texture: Int, calories: Int) {
            self.name = name
            self.capacity = capacity
            self.durability = durability
            self.flavor = flavor
            self.texture = texture
            self.calories = calories
        }
        
        convenience init(fromString str: String) {
            let vals = (str =~  "\\-?\\d+").items
            self.init(name: str.componentsSeparatedByString(":")[0], capacity: Int(vals[0])!, durability: Int(vals[1])!, flavor: Int(vals[2])!, texture: Int(vals[3])!, calories: Int(vals[4])!)
        }
    }
}

func ==(lhs: Day15.Ingredient, rhs: Day15.Ingredient) -> Bool {
    return lhs.name == rhs.name
}
