//
//  ContentView.swift
//  Challenge4HabitTracking
//
//  Created by Ahmet Büyükçelik on 18.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.items, id: \.self) { activity in
                    VStack(alignment: .leading) {
                        Text(activity.name)
                            .font(.headline)
                        Text(activity.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    
                }
                .onDelete(perform: RemoveRows)
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Label("Add Habit", systemImage: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddHabit(activities: activities)
                    }
                }
            }
        }
    }
    
    func RemoveRows(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
