//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ahmet Büyükçelik on 5.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var chosenFlag = ""
    @State private var alertMessage = ""
    @State private var questionCount = 1
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag three horizontal stripes. Top thin stripe red, middle thick stripe is gold with crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    @State private var rotationDegrees = [0.0, 0.0, 0.0]
    @State private var opacities = [1.0, 1.0, 1.0]
    @State private var selectedFlagIndex: Int? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.25), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.heavy))
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                                .rotation3DEffect(
                                    .degrees(rotationDegrees[number]),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(opacities[number])
                                .animation(.easeInOut(duration: 0.6), value: rotationDegrees[number])
                                .animation(.easeInOut(duration: 0.6), value: opacities[number])
                        }
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button(questionCount == 9 ? "Reset Game" : "Continue") {
                if questionCount == 9 {
                    userScore = 0
                    questionCount = 1
                }
                askQuestion()
            }
        } message: {
            Text(questionCount == 9 ? "Your Final score is \(userScore)" : alertMessage)
        }
        
    }
    
    func flagTapped (_ number: Int) {
        selectedFlagIndex = number
        withAnimation(.easeInOut(duration: 0.6)) {
            for i in 0..<3 {
                if i == number {
                    rotationDegrees[i] += 360
                    opacities[i] = 1.0
                } else {
                    rotationDegrees[i] -= 360
                    opacities[i] = 0.25
                }
            }
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            alertMessage = "Your score is \(userScore)"
            questionCount += 1
        } else {
            scoreTitle = "Wrong"
            userScore -= 1
            chosenFlag = countries[number]
            alertMessage = """
                    Wrong! That's the flag of \(chosenFlag)
                    Your score is \(userScore)
                """
            questionCount += 1
        }
        
        showingScore = true
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlagIndex = nil
        rotationDegrees = [0.0, 0.0, 0.0]
        opacities = [1.0, 1.0, 1.0]
    }
}

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
