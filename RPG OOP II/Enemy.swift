//
//  Enemy.swift
//  RPG OOP II
//
//  Created by Sibrian on 7/13/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//
// Properties specific to an enemy
// Will only have one enemy (troll)

import Foundation

class Enemy: Sprite {
    
    let MAX_DEFENSE = 12
    
    var type: String {
        return "Troll"
    }
    
    override func attemptAttack(attackPower: Int) -> Bool {
        if attackPower >= MAX_DEFENSE {
            return super.attemptAttack(attackPower)
        } else {
            return false
        }
    }
}
