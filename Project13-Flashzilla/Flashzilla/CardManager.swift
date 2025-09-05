//
//  CardManager.swift
//  Flashzilla
//
//  Created by Ahmet Büyükçelik on 29.08.2025.
//

import Foundation

@Observable
class CardManager {
    var cards: [Card] = []
    
    private let saveKey = "cards.json"
    
    init() {
        loadCards()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getCardsFileURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent(saveKey)
    }
    
    func loadCards() {
        let url = getCardsFileURL()
        
        do {
            let data = try Data(contentsOf: url)
            let decodedCards = try JSONDecoder().decode([Card].self, from: data)
            DispatchQueue.main.async {
                self.cards = decodedCards
            }
        } catch {
            DispatchQueue.main.async {
                self.cards = []
            }
        }
    }
    
    func saveCards() {
        let url = getCardsFileURL()
        
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: url)
        } catch {
            print("Failed to save cards: \(error.localizedDescription)")
        }
    }
    
    func addCard(_ card: Card) {
        cards.insert(card, at: 0)
        saveCards()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveCards()
    }
    
    func removeCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
            saveCards()
        }
    }
    
    func updateCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index] = card
            saveCards()
        }
    }
    
    func resetCards() {
        cards = []
        saveCards()
    }
    
    func reloadCards() {
        loadCards()
    }
    
    func createGameCards() {
        loadCards()
    }
}
