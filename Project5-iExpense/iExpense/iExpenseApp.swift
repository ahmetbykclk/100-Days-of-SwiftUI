//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ahmet Büyükçelik on 8.08.2025.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
