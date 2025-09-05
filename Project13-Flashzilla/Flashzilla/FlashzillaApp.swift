//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Ahmet Büyükçelik on 28.08.2025.
//

import SwiftUI

@main
struct FlashzillaApp: App {
    @State private var cardManager = CardManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(cardManager)
        }
    }
}
