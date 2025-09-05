//
//  DiceRoll.swift
//  Challenge7DiceRoll
//
//  Created by Ahmet Büyükçelik on 31.08.2025.
//

import Foundation
import SwiftData

@Model
class DiceRoll {
    var id = UUID()
    var timestamp = Date.now
    var diceType: DiceType
    var numberOfDice: Int
    var results: [Int]
    var total: Int
    
    init(diceType: DiceType, numberOfDice: Int, results: [Int], total: Int) {
        self.diceType = diceType
        self.numberOfDice = numberOfDice
        self.results = results
        self.total = total
    }
}

enum DiceType: Int, CaseIterable, Codable {
    case four = 4
    case six = 6
    case eight = 8
    case ten = 10
    case twelve = 12
    case twenty = 20
    case hundred = 100
    
    var displayName: String {
        return "\(self.rawValue)-sided"
    }
}

extension DiceRoll {
    static var example: DiceRoll {
        DiceRoll(diceType: .six, numberOfDice: 2, results: [3, 5], total: 8)
    }
}
