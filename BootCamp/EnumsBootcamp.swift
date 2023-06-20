//
//  EnumsBootcamp.swift
//  BootCamp
//
//  Created by MM on 28.05.2023.
//

import SwiftUI

enum Devices {
    case iPad, iPhone(color: String)
    
    var year: Int {
        switch self {
            case .iPad: return 2010
            case .iPhone: return 2020
            case .iPhone(color: "black"): return 2021
            case .iPhone(color: let color) where color == "black": return 2025
        }
    }
}

enum Character {
    enum Weapon: Int {
        case dagger = 4
        case wand = 1
        
        var damage: Int {
            return rawValue * 10
        }
    }
    
    enum Speciality {
        case knight
        case mage
    }
}

let char = Character.Weapon.dagger.damage

indirect enum Lunch {
    case soup
    case salad
    case meal(Lunch, Lunch)
}
