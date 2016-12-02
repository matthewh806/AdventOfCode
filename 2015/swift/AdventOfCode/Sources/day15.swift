//
//  day15.swift
//  AdventOfCode
//
//  Created by Matthew on 24/12/2015.
//  Copyright © 2015 Automata Theory. All rights reserved.
//

import Foundation

class Day15: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day15.txt", encoding: NSUTF8StringEncoding)
    
    func partOne() -> String {
        var ingredients: [Ingredient] = []
        input.componentsSeparatedByString("\n").forEach({ ingredients.append(Ingredient(fromString: $0))})
        return "\(getBestCookieScore(ingredients, numTeaspoons: 100))"
    }
    
    func partTwo() -> String {
        var ingredients: [Ingredient] = []
        input.componentsSeparatedByString("\n").forEach({ ingredients.append(Ingredient(fromString: $0))})
        return "\(getBestCookieScore(ingredients, numTeaspoons: 100, numCalories: 500))"

    }
    
    func testCode() -> String {
        let butterscotch = Ingredient(fromString: "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8")
        let cinnamon = Ingredient(fromString: "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3")
        return "\(getBestCookieScore([butterscotch, cinnamon], numTeaspoons: 100, numCalories: 500))"
    }
    
    func getBestCookieScore(ingredientsArray: [Ingredient], numTeaspoons: Int, numCalories: Int = 0) -> Int {
        return numCalories == 0 ? distributeTeaspoons([:], remainingTeaspoons: numTeaspoons, remainingIngredients: ingredientsArray).map({ Cookie.init(ingredients: $0).totalScore}).maxElement()! : (distributeTeaspoons([:], remainingTeaspoons: numTeaspoons, remainingIngredients: ingredientsArray).map({ Cookie.init(ingredients: $0) } ).filter({ $0.getCalories == 500 }).maxElement({ $0.totalScore < $1.totalScore })?.totalScore)!
    }
    
    func distributeTeaspoons(ingredients: [Ingredient:Int], remainingTeaspoons: Int) -> [[Ingredient:Int]] {
        if remainingTeaspoons == 0 {
            return [ingredients]
        } else {
            var arrangements: [[Ingredient:Int]] = []
            for (k, _) in ingredients {
                var newIngredients = ingredients
                newIngredients[k]! += 1
                arrangements += distributeTeaspoons(newIngredients, remainingTeaspoons: remainingTeaspoons-1)
            }
            return arrangements
        }
    }
    
    func distributeTeaspoons(ingredients: [Ingredient:Int], remainingTeaspoons: Int, remainingIngredients: [Ingredient]) -> [[Ingredient:Int]] {
        if remainingIngredients.count == 1 {
            var newIngredients = ingredients
            newIngredients[remainingIngredients[0]] = remainingTeaspoons
            return [newIngredients]
        } else {
            var arrangements: [[Ingredient:Int]] = []
            for i in 0...remainingTeaspoons {
                var newIngredients = ingredients
                var stillRemainingIngredients = remainingIngredients
                let nextIngredient = stillRemainingIngredients.removeFirst()
                newIngredients[nextIngredient] = i
                arrangements += distributeTeaspoons(newIngredients, remainingTeaspoons: remainingTeaspoons-i, remainingIngredients: stillRemainingIngredients)
            }
            
            return arrangements
        }
    }
    
    class Cookie{
        let MAX_INGREDIENTS = 100
        var ingredients: [Ingredient: Int]
        
        init(ingredients: [Ingredient: Int]) {
            self.ingredients = ingredients
        }
        
        var getCalories: Int {
            return ingredients.reduce(0, combine: { $0 + ($1.0.calories * $1.1) })
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
