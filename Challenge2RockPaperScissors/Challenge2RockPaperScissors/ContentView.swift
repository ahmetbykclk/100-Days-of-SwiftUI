//
//  ContentView.swift
//  Challenge2RockPaperScissors
//
//  Created by Ahmet Büyükçelik on 5.08.2025.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var computerMove = ""
    @State private var userShouldWin = Bool.random()
    @State private var showResult = false
    @State private var isWon = false
    
    @State private var userScore = 0
    @State private var roundCount = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Score: \(userScore)")
                .font(.largeTitle)
            
            Text("Round: \(roundCount)/10")
                .font(.title2)
            
            if showResult {
                Text("Computer Move: \(computerMove)")
                    .font(.title2)
                Text(isWon ? "You Win" : "You Lose")
                    .foregroundStyle(isWon ? .green : .red)
                    .font(.title)
            }

            if roundCount < 10 {
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button(move) {
                            play(userMove: move)
                        }
                    }
                }
                .buttonStyle(.bordered)
                .font(.title)
            } else {
                Button("Reset Game") {
                    resetGame()
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
            }
        }
        .padding()
    }
    
    func play(userMove: String) {
        let winningMoves: [String: String] = ["Rock": "Scissors", "Paper": "Rock", "Scissors": "Paper"]
        let losingMoves: [String: String] = ["Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock"]

        if userShouldWin {
            computerMove = winningMoves[userMove] ?? ""
        } else {
            computerMove = losingMoves[userMove] ?? ""
        }
        
        isWon = userShouldWin
        userScore += userShouldWin ? 1 : -1
        roundCount += 1
        
        showResult = true
        
        userShouldWin = Bool.random()
    }
    
    func resetGame() {
        userScore = 0
        roundCount = 0
        computerMove = ""
        showResult = false
        userShouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
