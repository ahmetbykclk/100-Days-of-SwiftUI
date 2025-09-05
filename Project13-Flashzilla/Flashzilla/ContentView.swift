//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ahmet Büyükçelik on 28.08.2025.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    
    @Environment(CardManager.self) var cardManager
    @State private var showingEditScreen = false
    @State private var isActive = true
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cardManager.cards) { card in
                        CardView(card: card) { correct in
                            withAnimation {
                                handleCard(card, correct: correct)
                            }
                        }
                        .stacked(at: cardManager.cards.firstIndex(of: card) ?? 0, in: cardManager.cards.count)
                        .allowsHitTesting(card.id == cardManager.cards.last?.id)
                        .accessibilityHidden(card.id != cardManager.cards.last?.id)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cardManager.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }

                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                    if let card = cardManager.cards.last {
                                        handleCard(card, correct: false) 
                                    }
                                }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")

                        Spacer()

                        Button {
                            withAnimation {
                                    if let card = cardManager.cards.last {
                                        handleCard(card, correct: true)
                                    }
                                }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                        
                    }
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cardManager.cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
                .environment(cardManager)
        }
        .onAppear(perform: resetCards)
    }
    func handleCard(_ card: Card, correct: Bool) {
        guard let index = cardManager.cards.firstIndex(where: { $0.id == card.id }) else { return }
        var cardToRemove = cardManager.cards[index]
        
        cardManager.cards.remove(at: index)

        if !correct {
            cardToRemove.id = UUID()
            cardManager.cards.insert(cardToRemove, at: 0)
        }

        if cardManager.cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cardManager.reloadCards()
        }
    }
}

#Preview {
    ContentView()
}
