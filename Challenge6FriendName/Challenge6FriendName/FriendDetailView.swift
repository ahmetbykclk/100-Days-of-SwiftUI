//
//  FriendDetailView.swift
//  Challenge6FriendName
//
//  Created by Ahmet Büyükçelik on 26.08.2025.
//

import SwiftUI
import MapKit

struct FriendDetailView: View {
    let friend: Friend
    @State private var showingMap = false
    
    var body: some View {
        ScrollView {
            VStack {
                if let uiImage = UIImage(data: friend.photo) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                }
                
                Button(friend.latitude != nil && friend.longitude != nil ? "Show Location" : "Set Location") {
                    showingMap = true
                }
                .padding()
                .background(friend.latitude != nil && friend.longitude != nil ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(friend.latitude != nil && friend.longitude != nil ? .white : .primary)
                .cornerRadius(8)
                .padding()
            }
            .navigationTitle(friend.name)
            .padding()
        }
        .sheet(isPresented: $showingMap) {
            MapView(coordinate: {
                if let latitude = friend.latitude, let longitude = friend.longitude {
                    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                } else {
                    return nil
                }
            }(), friend: friend)
        }
    }
}

#Preview {
    NavigationStack {
        FriendDetailView(friend: Friend(name: "Test Friend", photo: Data()))
    }
}
