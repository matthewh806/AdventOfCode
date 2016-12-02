//
//  day22.swift
//  AdventOfCode
//
//  Created by Matthew on 23/01/2016.
//  Copyright © 2016 Automata Theory. All rights reserved.
//

import Foundation

class Day22 : Day {
    let spells: [Spell] = [
        Spell(type: Spell.eType.MagicMissile, cost: 53, duration: 0),
        Spell(type: Spell.eType.Drain, cost: 73, duration: 0),
        Spell(type: Spell.eType.Shield, cost: 113, duration: 6),
        Spell(type: Spell.eType.Poison, cost: 173, duration: 6),
        Spell(type: Spell.eType.Recharge, cost: 229, duration: 5)
    ]
    
    func partOne() -> String {
        let boss = Day21.character(hp: 71, damage: 10, armor: 0)
        let player = magicPlayer(hp: 50, mana: 500)
        
        return "\(getMinManaBattle(player, player2: boss))"
        //return ""
    }
    
    func partTwo() -> String {
        return ""
    }
    
    func testCode() -> String {
        let testBoss = Day21.character(hp: 14, damage: 8, armor: 0)
        let testPlayer = magicPlayer(hp: 10, mana: 250)
        
        return "\(getMinManaBattle(testPlayer, player2: testBoss))"
    }
    
    func getMinManaBattle(player1: magicPlayer, player2: Day21.character) -> Int {
        var minMana = Int.max
        
        for i in 0..<spells.count {
            let p1 = player1.copy()
            let p2 = player2.copy()
            round(p1, player2: p2, nextSpell: spells[i])
            
            //print("Battle Result: p1: \(player1)\n p2: \(player2)\n\n")
            if(player1.hp > 0) {
                minMana = min(player1.totalManaSpent, minMana)
            }
        }
        
        return minMana
    }
    
    func round(player1: magicPlayer, player2: Day21.character, nextSpell: Spell) -> Void {
        player1.applyActiveSpells()
        
        //player 1 turn
        
        // Check if player can cast any spells at all...
        if spells.filter( { $0.cost <= player1.mana } ).count == 0 {
            player1.hp = 0
            return
        }
        
        if player1.canCastSpell(nextSpell) {
            player1.castSpell(nextSpell, enemy: player2)
        }
        player1.applyActiveSpells()
        
        if(player1.alive() && player2.alive()) {
            //enemy turn
            player2.takeTurn(player1)
        } else {
            if player1.alive() { print(player1.totalManaSpent) }
            return
        }
        
        //print("----Round Result: p1: \(player1)\n p2: \(player2)\n\n")
        if(player1.alive() && player2.alive()) {
            for i in 0..<spells.count {
                let p1 = player1.copy()
                let p2 = player2.copy()
                round(p1, player2: p2, nextSpell: spells[i])
            }
        } else {
            if player1.alive() { print(player1.totalManaSpent); }
            return
        }
    }
    
    class magicPlayer : Day21.character {
        var mana: Int
        var totalManaSpent = 0
        typealias spellEffect = () -> Void
        var activeSpells: [Spell: spellEffect] = [Spell: spellEffect]()
        
        override var description:String {
            return super.description + ", mana: \(mana)"
        }
        
        init(hp: Int, mana: Int) {
            self.mana = mana
            super.init(hp: hp, damage: 0, armor: 0)
        }
        
        convenience init(player: magicPlayer) {
            self.init(hp: player.hp, mana: player.mana)
            self.totalManaSpent = player.totalManaSpent
            self.activeSpells = player.activeSpells
        }
        
        override func copy() -> magicPlayer {
            return magicPlayer(player: self)
        }
        
        override func takeTurn(enemy: Day21.character) {
            //tryCastSpell(enemy)
        }
        
        func canCastSpell(spell: Spell) -> Bool {
            return (!activeSpells.keys.contains(spell) && spell.cost <= mana)
        }
        
        func castSpell(spell: Spell, enemy: Day21.character) {
            if(!canCastSpell(spell)) { return }
            //print("Cast: \(spell.type)")
            mana -= spell.cost
            totalManaSpent += spell.cost
            
            switch spell.type {
            case Spell.eType.MagicMissile:
                enemy.takeDamage(4)
                break
            case Spell.eType.Drain:
                enemy.takeDamage(2)
                self.healHP(2)
                break
            case Spell.eType.Shield:
                activeSpells[spell] = { self.armor = 7 }
                break
            case Spell.eType.Poison:
                activeSpells[spell] = { enemy.takeDamage(3) }
                break
            case Spell.eType.Recharge:
                activeSpells[spell] = { self.mana += 101 }
                break
            }
        }
        
        func healHP(amount: Int) {
            hp += amount
        }
        
        func applyActiveSpells() {
            activeSpells.forEach { (spell, effect) -> () in
                //print("Spell: \(spell.type), dur: \(spell.duration)")
                effect()
                spell.reduceDuration()
            }
            
            activeSpells = Dictionary( activeSpells.filter { (spell, _) -> Bool in
                spell.duration > 0
            })
            print(activeSpells.keys)
        }
    }
    
    class Spell: Equatable, Hashable {
        enum eType {
            case MagicMissile, Drain, Shield, Poison, Recharge
        }
        
        let type: eType
        let cost: Int
        var duration: Int //0 is an instantaneous effect
        var hashValue: Int {
            return self.type.hashValue
        }
        
        init(type: eType, cost: Int, duration: Int) {
            self.type = type
            self.cost = cost
            self.duration = duration
        }
        
        func reduceDuration() {
            duration -= 1
        }
    }
}

func ==(lhs: Day22.Spell, rhs: Day22.Spell) -> Bool {
    return lhs.type == rhs.type && lhs.cost == rhs.cost && lhs.duration == rhs.duration
}

extension Dictionary {
    init(_ elements: [Element]) {
        self.init()
        for (k,v) in elements {
            self[k] = v
        }
    }
    
    func filter(includeElement: Element -> Bool) -> [Key:Value] {
        return Dictionary(self.filter( includeElement ))
    }
}
