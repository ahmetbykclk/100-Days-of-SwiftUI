//
//  ContentView.swift
//  Moonshot
//
//  Created by Ahmet Büyükçelik on 8.08.2025.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if showingGrid {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            MissionCardView(mission: mission, astronauts: astronauts)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .accessibilityLabel("Missions grid view")
                    .accessibilityHint("Double tap to view mission details")
                } else {
                    LazyVStack(spacing: 10) {
                        ForEach(missions) { mission in
                            MissionCardView(mission: mission, astronauts: astronauts)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .accessibilityLabel("Missions list view")
                    .accessibilityHint("Double tap to view mission details")
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                            .font(.title2)
                            .dynamicTypeSize(.large ... .accessibility3)
                    }
                    .accessibilityLabel(showingGrid ? "Switch to list view" : "Switch to grid view")
                    .accessibilityHint("Changes the layout of mission cards")
                    .accessibilityAddTraits(.allowsDirectInteraction)
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: Astronaut.self) { astronaut in
                AstronautView(astronaut: astronaut)
            }
        }
        .accessibilityElement(children: .contain)
        
    }
}

#Preview {
    ContentView()
}
