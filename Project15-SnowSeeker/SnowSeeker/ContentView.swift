//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ahmet Büyükçelik on 1.09.2025.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortOption: SortOption = .defaultOrder
    
    enum SortOption: String, CaseIterable, Hashable {
        case defaultOrder
        case alphabetical
        case country
        
        var title: String {
            switch self {
            case .defaultOrder: return "Default"
            case .alphabetical: return "Alphabetical"
            case .country: return "Country"
            }
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sortOption {
        case .defaultOrder:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .country:
            return filteredResorts.sorted { lhs, rhs in
                if lhs.country != rhs.country {
                    return lhs.country.localizedCaseInsensitiveCompare(rhs.country) == .orderedAscending
                } else {
                    return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
                }
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Picker("Sort", selection: $sortOption) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.title).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityLabel("Sort resorts")
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
