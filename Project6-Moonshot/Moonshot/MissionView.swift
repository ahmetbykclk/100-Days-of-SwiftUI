//
//  MissionView.swift
//  Moonshot
//
//  Created by Ahmet Büyükçelik on 13.08.2025.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.bottom)
                    .accessibilityLabel("Mission patch for \(mission.displayName)")
                    .accessibilityHidden(true)
                
                Text(mission.formattedLaunchDate)
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.5))
                    .dynamicTypeSize(.large ... .accessibility3)
                    .accessibilityLabel("Launch date: \(mission.formattedLaunchDate)")
                
                VStack(alignment: .leading) {
                    DividerView()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                        .dynamicTypeSize(.large ... .accessibility3)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text(mission.description)
                        .dynamicTypeSize(.large ... .accessibility3)
                        .accessibilityLabel("Mission description: \(mission.description)")
                    
                    DividerView()
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                        .dynamicTypeSize(.large ... .accessibility3)
                        .accessibilityAddTraits(.isHeader)
                    
                }
                .padding(.horizontal)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Mission information")
                
                CrewMemberView(crew: crew)
                    .accessibilityLabel("Crew members")
                    .accessibilityHint("Scroll horizontally to view all crew members")
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .accessibilityElement(children: .contain)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
    
}
