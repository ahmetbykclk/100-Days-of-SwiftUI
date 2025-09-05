//
//  Challenge7DiceRollApp.swift
//  Challenge7DiceRoll
//
//  Created by Ahmet Büyükçelik on 31.08.2025.
//

import SwiftUI
import SwiftData

@main
struct Challenge7DiceRollApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DiceRoll.self)
    }
}
