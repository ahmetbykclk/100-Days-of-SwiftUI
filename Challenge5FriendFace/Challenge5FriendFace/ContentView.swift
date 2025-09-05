//
//  ContentView.swift
//  Challenge5FriendFace
//
//  Created by Ahmet Büyükçelik on 22.08.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink(destination: DetailView(user: user)) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title)
                            .bold()
                        Text(user.isActive ? "Active" : "Inactive")
                            .font(.headline)
                            .foregroundStyle(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("Users")
            .onAppear {
                if users.isEmpty {
                    Task {
                        await loadData()
                    }
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            // Save to SwiftData
            await MainActor.run {
                for user in decodedUsers {
                    modelContext.insert(user)
                }
                
                try? modelContext.save()
            }
            
        } catch {
            print("Invalid Data: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [User.self, Friend.self])
}
