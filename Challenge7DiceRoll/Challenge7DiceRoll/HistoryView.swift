//
//  HistoryView.swift
//  Challenge7DiceRoll
//
//  Created by Ahmet Büyükçelik on 31.08.2025.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    let rolls: [DiceRoll]
    
    var body: some View {
        List {
            ForEach(rolls) { roll in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("\(roll.diceType.displayName) - \(roll.numberOfDice) dice")
                            .font(.headline)
                        Spacer()
                        Text("Total: \(roll.total)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    Text("Results: \(roll.results.map(String.init).joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(roll.timestamp, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .onDelete(perform: deleteRolls)
        }
        .navigationTitle("Roll History")
    }
    
    func deleteRolls(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(rolls[index])
        }
    }
}

#Preview {
    NavigationStack {
        HistoryView(rolls: [DiceRoll.example])
    }
}
