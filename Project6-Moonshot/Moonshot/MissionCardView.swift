//
//  MissionCardView.swift
//  Moonshot
//
//  Created by Ahmet Büyükçelik on 13.08.2025.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        NavigationLink(value: mission) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()
                        .accessibilityLabel("Mission patch for \(mission.displayName)")
                        .accessibilityHidden(true)
                    
                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .dynamicTypeSize(.large ... .accessibility3)
                        
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                            .dynamicTypeSize(.large ... .accessibility3)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel("\(mission.displayName), launched \(mission.formattedLaunchDate)")
                .accessibilityHint("Double tap to view mission details and crew information")
                .accessibilityAddTraits(.isButton)
            
        }
        }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionCardView(mission: missions[0], astronauts: astronauts)
        .background(.darkBackground)
        .preferredColorScheme(.dark)
}
