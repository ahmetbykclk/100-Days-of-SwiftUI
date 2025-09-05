//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Ahmet Büyükçelik on 21.08.2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
