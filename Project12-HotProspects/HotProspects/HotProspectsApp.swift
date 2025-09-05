//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Ahmet Büyükçelik on 27.08.2025.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
