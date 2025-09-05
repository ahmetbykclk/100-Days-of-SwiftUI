//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ahmet Büyükçelik on 20.08.2025.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
