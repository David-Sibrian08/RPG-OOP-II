//
//  Hero.swift
//  RPG OOP II
//
//  Created by Sibrian on 7/13/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//
// Properties specific to a Hero (good guy)

import Foundation

class Hero: Sprite {
    private var _name = "User10992"
    
    var name: String {
        get {
            return _name
        }
    }
    
    convenience init (heroName: String, HP: Int, attackPower: Int) {
        self.init(startingHP: HP, initialAttackPower: attackPower)
        self._name = heroName
    }
}