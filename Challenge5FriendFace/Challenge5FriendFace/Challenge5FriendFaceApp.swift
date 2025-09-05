//
//  Challenge5FriendFaceApp.swift
//  Challenge5FriendFace
//
//  Created by Ahmet Büyükçelik on 22.08.2025.
//

import SwiftUI
import SwiftData

@main
struct Challenge5FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Friend.self])
    }
}
