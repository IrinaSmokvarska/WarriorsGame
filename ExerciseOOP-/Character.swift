//
//  Character.swift
//  ExerciseOOP-
//
//  Created by Darko Spasovski on 2/3/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int = 100
    private var _attackPower: Int = 10
    private var _name: String = "Character"
    
     var hp: Int {
        get {
            return _hp
        }
    }
    
     var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
     var name: String {
        get {
            return _name
        }
    }
    
    var isAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    init(startingHp: Int, attackPwr: Int, name: String) {
         self._hp = startingHp
        self._attackPower = attackPwr
        self._name = name
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        
        return true
    }

    
    
}
