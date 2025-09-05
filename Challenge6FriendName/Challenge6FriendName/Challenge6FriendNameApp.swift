//
//  Challenge6FriendNameApp.swift
//  Challenge6FriendName
//
//  Created by Ahmet Büyükçelik on 26.08.2025.
//

import SwiftUI
import SwiftData

@main
struct Challenge6FriendNameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Friend.self)
    }
}
