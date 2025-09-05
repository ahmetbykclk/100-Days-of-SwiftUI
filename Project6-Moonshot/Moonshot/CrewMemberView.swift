//
//  CrewMemberView.swift
//  Moonshot
//
//  Created by Ahmet Büyükçelik on 13.08.2025.
//

import SwiftUI

struct CrewMemberView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember.astronaut) {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                                .accessibilityLabel("Photo of \(crewMember.astronaut.name)")
                                .accessibilityHidden(true)
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .dynamicTypeSize(.large ... .accessibility3)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                                    .dynamicTypeSize(.large ... .accessibility3)
                            }
                            
                        }
                        .padding(.horizontal)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(crewMember.astronaut.name), \(crewMember.role)")
                        .accessibilityHint("Double tap to view astronaut details")
                        .accessibilityAddTraits(.isButton)
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crew = missions[0].crew.map { member in
        if let astronaut = astronauts[member.name] {
            return MissionView.CrewMember(role: member.role, astronaut: astronaut)
        } else {
            fatalError("Missing \(member.name)")
        }
    }
    
    return CrewMemberView(crew: crew)
        .background(.darkBackground)
        .preferredColorScheme(.dark)
}
