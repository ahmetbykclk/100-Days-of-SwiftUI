//
//  ContentView.swift
//  Challenge7DiceRoll
//
//  Created by Ahmet Büyükçelik on 31.08.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \DiceRoll.timestamp, order: .reverse) private var savedRolls: [DiceRoll]
    @State private var selectedDiceType: DiceType = .six
    @State private var numberOfDice = 1
    @State private var currentResults = [Int]()
    @State private var isRolling = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Dice Type", selection: $selectedDiceType) {
                        ForEach(DiceType.allCases, id: \.self) { diceType in
                            Text(diceType.displayName).tag(diceType)
                        }
                    }
                    Stepper("Number of Dice: \(numberOfDice)", value: $numberOfDice, in: 1...3)
                }
                Section {
                    Button("Roll Dice") {
                        rollDice()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(isRolling)
                    .sensoryFeedback(.impact(weight: .medium), trigger: isRolling)
                }
                if !currentResults.isEmpty {
                    Section("Results") {
                        ForEach(currentResults.indices, id: \.self) { index in
                            HStack {
                                Text("Dice \(index + 1):")
                                Spacer()
                                Text("\(currentResults[index])")
                                    .fontWeight(.bold)
                            }
                        }
                        
                        HStack {
                            Text("Total:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(currentResults.reduce(0, +))")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            
            .navigationTitle("Dice Roll")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("History") {
                        HistoryView(rolls: savedRolls)
                    }
                }
            }
        }
    }
    
    func rollDice() {
        isRolling = true
        
        var counter = 0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            currentResults = (0..<numberOfDice).map { _ in
                Int.random(in: 1...selectedDiceType.rawValue)
            }
            counter += 1
            
            if counter >= 10 {
                timer.invalidate()
                isRolling = false
                
                saveRoll()
            }
        }
        
        
    }
    
    func saveRoll() {
        let newRoll = DiceRoll(
            diceType: selectedDiceType,
            numberOfDice: numberOfDice,
            results: currentResults,
            total: currentResults.reduce(0, +)
        )
        modelContext.insert(newRoll)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DiceRoll.self, inMemory: true)
}
