//
//  Activity.swift
//  Challenge4HabitTracking
//
//  Created by Ahmet Büyükçelik on 18.08.2025.
//

import Foundation

struct Activity: Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    let description: String
}
