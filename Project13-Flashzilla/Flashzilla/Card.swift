//
//  Card.swift
//  Flashzilla
//
//  Created by Ahmet Büyükçelik on 28.08.2025.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
