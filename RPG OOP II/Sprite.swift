//
//  Sprite.swift
//  RPG OOP II
//
//  Created by Sibrian on 7/13/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import Foundation

class Sprite {
    private var _HP = 100
    private var _attackPower = 25
    
    var HP: Int {
        get {
            return _HP
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
    var isDead: Bool {
        get {
            if HP <= 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    init(startingHP: Int, initialAttackPower: Int) {
        self._HP = startingHP
        self._attackPower = initialAttackPower
    }
    
    func attemptAttack(attackPower:Int) -> Bool {
        self._HP -= attackPower
        
        return true
    }
}