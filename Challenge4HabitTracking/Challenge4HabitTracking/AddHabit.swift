//
//  AddHabit.swift
//  Challenge4HabitTracking
//
//  Created by Ahmet Büyükçelik on 18.08.2025.
//

import SwiftUI

struct AddHabit: View {
    @Environment(\.dismiss) var dismiss
    @State var habitName: String = ""
    @State var habitDescription: String = ""
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Habit Name", text: $habitName)
                }
                Section {
                    TextField("Description", text: $habitDescription)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            let newHabit = Activity(name: habitName, description: habitDescription)
                            activities.items.append(newHabit)
                            dismiss()
                        }
                    }
                    
                }
                .navigationTitle("Add Habit")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddHabit(activities: Activities())
}
