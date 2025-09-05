//
//  ContentView.swift
//  Challenge3Edutainment
//
//  Created by Ahmet Büyükçelik on 7.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMultiply = 2
    @State private var selectedQuestionNumber = 5
    @State private var questions = [Question]()
    @State private var score = 0
    @State private var gameState: GameState = .settings
    @State private var currentQuestion = 0
    @State private var userAnswer = ""
    
    let questionNumbers = [5, 10, 20]
    
    var body: some View {
        if gameState == .settings {
            NavigationStack {
                Form {
                    Section("Choose Question Number") {
                        Picker("Question Number", selection: $selectedQuestionNumber) {
                            ForEach(questionNumbers, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                        
                        Section ("Choose Multiplying Number") {
                        Stepper("Selected Multiply: \(selectedMultiply)", value: $selectedMultiply, in: 2...12)
                        }
                    Button("Start Game") {
                        questions.removeAll()
                        for _ in 1...selectedQuestionNumber {
                            let randomNumber = Int.random(in: 2...12)
                            let text = "What is \(selectedMultiply) times \(randomNumber)?"
                            let answer = selectedMultiply * randomNumber
                            questions.append(Question(text: text, answer: answer))
                        }
                        gameState = .playing
                    }
                }
                .navigationTitle("Settings")
            }
        } else if gameState == .playing {
            NavigationStack {
                VStack {
                    Text("\(questions[currentQuestion].text)")
                        .font(.largeTitle)
                        .padding()
                    TextField("Enter your answer", text: $userAnswer)
                        .keyboardType(.numberPad)
                        .padding()
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                    Button("Submit") {
                        if Int(userAnswer) ?? 0 == questions[currentQuestion].answer {
                            score += 1
                        } else {
                            score -= 1
                        }
                        userAnswer = ""
                        currentQuestion += 1
                        if currentQuestion == questions.count {
                            gameState = .finished
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .navigationTitle("Game")
            }
        } else {
            NavigationStack {
                VStack {
                    Text("Your score is \(score)")
                        .font(.largeTitle)
                        .padding()
                    Button("Restart") {
                        score = 0
                        currentQuestion = 0
                        questions.removeAll()
                        gameState = .settings
                    }
                    .buttonStyle(.bordered)
                        
                }
                .navigationTitle("Results")
            }
        }
    }
    
}

enum GameState {
    case settings, playing, finished
}

struct Question {
    let text: String
    let answer: Int
}

#Preview {
    ContentView()
}
