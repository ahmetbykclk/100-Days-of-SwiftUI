//
//  ContentView.swift
//  Challenge6FriendName
//
//  Created by Ahmet Büyükçelik on 26.08.2025.
//

import SwiftUI
import SwiftData
import PhotosUI
import CoreLocation

struct ContentView: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingNameAlert = false
    @State private var selectedPhotoData: Data?
    @State private var isShowingSheet = false
    @State private var friendName = ""
    @State private var showingLocationPicker = false
    @State private var newlyCreatedFriend: Friend?
    @Environment(\.modelContext) private var modelContext
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    NavigationLink(destination: FriendDetailView(friend: friend)) {
                        HStack {
                            if let uiImage = UIImage(data: friend.photo) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            Text(friend.name)
                        }
                    }
                }
                .onDelete(perform: deleteFriends)
            }
            .navigationBarTitle("Friends")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Friend", systemImage: "plus") {
                        isShowingSheet = true
                    }
                }
            }
            .onAppear {
                locationFetcher.start()
            }
            .sheet(isPresented: $isShowingSheet) {
                PhotosPicker("Select a photo", selection: $selectedItem, matching: .images)
            }
            .sheet(isPresented: $showingLocationPicker) {
                if let friend = newlyCreatedFriend {
                    MapView(coordinate: locationFetcher.lastKnownLocation, friend: friend)
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                        showingNameAlert = true
                        isShowingSheet = false
                    }
                }
            }
            .sheet(isPresented: $showingNameAlert) {
                NavigationStack {
                    VStack {
                        Text("Enter Friend's Name")
                            .font(.title2)
                            .padding()
                        
                        TextField("Name", text: $friendName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        HStack {
                            Button("Cancel") {
                                showingNameAlert = false
                                friendName = ""
                                selectedPhotoData = nil
                            }
                            .padding()
                            
                            Button("Save") {
                                if let photoData = selectedPhotoData, !friendName.isEmpty {
                                    let friend = Friend(
                                        name: friendName, 
                                        photo: photoData
                                    )
                                    modelContext.insert(friend)
                                    newlyCreatedFriend = friend
                                    friendName = ""
                                    selectedPhotoData = nil
                                    showingNameAlert = false
                                    showingLocationPicker = true
                                }
                            }
                            .disabled(friendName.isEmpty)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }
    func deleteFriends(at offsets: IndexSet) {
        for offset in offsets {
            let friendToDelete = friends[offset]
            modelContext.delete(friendToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
