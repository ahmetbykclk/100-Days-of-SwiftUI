//
//  EditCards.swift
//  Flashzilla
//
//  Created by Ahmet Büyükçelik on 29.08.2025.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CardManager.self) var cardManager
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }
                
                Section {
                    ForEach(0..<cardManager.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cardManager.cards[index].prompt)
                                .font(.headline)
                            
                            Text(cardManager.cards[index].answer)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .onAppear(perform: cardManager.reloadCards)
        }
    }
    func done() {
        dismiss()
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else {
            return
        }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cardManager.addCard(card)
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        cardManager.removeCards(at: offsets)
    }
}

#Preview {
    EditCards()
}
