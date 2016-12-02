//
//  day21.swift
//  AdventOfCode
//
//  Created by Matthew on 06/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

import Foundation

class Day21: Day {
    let input = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day21.txt", encoding: NSUTF8StringEncoding)
    let shopInput = try! String(contentsOfFile:"/Users/matthew/Projects/swift/AdventOfCode/AdventOfCode/Input/day21_shop.txt", encoding: NSUTF8StringEncoding)
    
    let calcCost = { (items: [item]) -> Int in
        return items.reduce( 0, combine: {$0 + $1.cost} )
    }
    
    let weapons: [item] = [
        item(name: "Dagger", cost: 8, Damage: 4, Armor: 0),
        item(name: "Shortsword", cost: 10, Damage: 5, Armor: 0),
        item(name: "Warhammer", cost: 25, Damage: 6, Armor: 0),
        item(name: "Longsword", cost: 40, Damage: 7, Armor: 0),
        item(name: "Greataxe", cost: 74, Damage: 8, Armor: 0)
    ]
    
    let armors: [item] = [ // stupid name, but it helps for consistency below
        item(name: "None", cost: 0, Damage: 0, Armor: 0),
        item(name: "Leather", cost: 13, Damage: 0, Armor: 1),
        item(name: "Chainmail", cost: 31, Damage: 0, Armor: 2),
        item(name: "Splintmail", cost: 53, Damage: 0, Armor: 3),
        item(name: "Bandedmail", cost: 75, Damage: 0, Armor: 4),
        item(name: "Platemail", cost: 102, Damage: 0, Armor: 5)
    ]
    
    let rings: [item] = [
        item(name: "None0", cost: 0, Damage: 0, Armor: 0),
        item(name: "None1", cost: 0, Damage: 0, Armor: 0),
        item(name: "Damage +1", cost: 25, Damage: 1, Armor: 0),
        item(name: "Damage +2", cost: 50, Damage: 2, Armor: 0),
        item(name: "Damage +3", cost: 100, Damage: 3, Armor: 0),
        item(name: "Defense +1", cost: 20, Damage: 0, Armor: 1),
        item(name: "Defense +2", cost: 40, Damage: 0, Armor: 2),
        item(name: "Defense +3", cost: 80, Damage: 0, Armor: 3)
    ]
    
    func partOne() -> String {
        var minCost = Int.max
        for weapon in weapons {
            for armor in armors {
                for firstRing in rings {
                    for secondRing in rings {
                        if(firstRing == secondRing) { continue }
                        let items = [weapon, armor, firstRing, secondRing]
                        if(battle(player(hp: 100, items: items), player2: character(hp: 109, damage: 8, armor: 2))) { minCost = min(calcCost(items), minCost) }
                    }
                }
            }
        }
        
        return "Minumum cost to win: \(minCost)"
    }
    
    func partTwo() -> String {
        var maxCost = Int.min
        for weapon in weapons {
            for armor in armors {
                for firstRing in rings {
                    for secondRing in rings {
                        if(firstRing == secondRing) { continue }
                        let items = [weapon, armor, firstRing, secondRing]
                        if(!battle(player(hp: 100, items: items), player2: character(hp: 109, damage: 8, armor: 2))) { maxCost = max(calcCost(items), maxCost) }
                    }
                }
            }
        }
        
        return "Maximum cost to lose: \(maxCost)"
    }
    
    func testCode() -> String {
        let boss = character(hp: 12, damage: 7, armor: 2)
        let play = character(hp: 8, damage: 5, armor: 5)
        
        let winner = battle(play, player2: boss) ? "player!" : "boss!"
        return "Who wins? \(winner)"
    }
    
    //returns player 1 win or lose bool
    func battle(player1: character, player2: character) -> Bool {
        
        var count = 0
        repeat {
            count % 2 == 0 ? player1.attack(player2) : player2.attack(player1)
            count++
        } while ( player1.alive() && player2.alive() )
        
        return player1.alive()
    }
    
    class player : character {
        init(hp: Int, items:[item]) {
            let damage = items.reduce(0, combine: { $0 + $1.Damage })
            let armor = items.reduce(0, combine: { $0 + $1.Armor })
            super.init(hp: hp, damage: damage, armor: armor)
        }
    }
    
    class character : CustomStringConvertible {
        var hp: Int
        var damage: Int = 0
        var armor: Int = 0
        
        var description: String {
            return "hp: \(hp), dmg: \(damage), armor: \(armor)"
        }
        
        init(hp: Int, damage: Int, armor: Int) {
            self.hp = hp
            self.damage = damage
            self.armor = armor
        }
        
        convenience init(char: character) {
            self.init(hp: char.hp, damage: char.damage, armor: char.armor)
        }
        
        func copy() -> character {
            return character(char: self)
        }
        
        func takeTurn(enemy: character) {
            attack(enemy)
        }
        
        func attack(enemy: character) {
            enemy.takeDamage(self.damage - enemy.armor)
        }
        
        func takeDamage(amount: Int) {
            hp -= ( amount < 1 ? 1 : amount)
        }
        
        func alive() -> Bool {
            return hp > 0
        }
    }
    
    struct item : Equatable{
        let name: String
        let cost: Int
        let Damage: Int
        let Armor: Int
    }
}

func ==(lhs: Day21.item, rhs: Day21.item) -> Bool {
    return lhs.name == rhs.name && lhs.cost == rhs.cost && lhs.Damage == rhs.Damage && lhs.Armor == rhs.Armor
}
