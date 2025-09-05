//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ahmet Büyükçelik on 13.08.2025.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("Photo of \(astronaut.name)")
                    .accessibilityHidden(true)
                
                Text(astronaut.description)
                    .padding()
                    .dynamicTypeSize(.large ... .accessibility3)
                    .accessibilityLabel("Astronaut biography: \(astronaut.description)")
            }
            
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronautView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
