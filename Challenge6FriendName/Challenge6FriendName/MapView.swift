//
//  MapView.swift
//  Challenge6FriendName
//
//  Created by Ahmet Büyükçelik on 26.08.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    let coordinate: CLLocationCoordinate2D?
    let friend: Friend
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var region: MKCoordinateRegion
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    init(coordinate: CLLocationCoordinate2D?, friend: Friend) {
        self.coordinate = coordinate
        self.friend = friend
        
        let initialCoordinate = coordinate ?? CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784)
        self._region = State(initialValue: MKCoordinateRegion(
            center: initialCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
        self._selectedCoordinate = State(initialValue: coordinate)
    }
    
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                Map(position: .constant(.region(region)), interactionModes: .all) {
                    if let selectedCoordinate = selectedCoordinate {
                        Marker("Photo Location", coordinate: selectedCoordinate)
                            .tint(.red)
                    }
                }
                .onTapGesture { location in
                    if let coordinate = proxy.convert(location, from: .local) {
                        selectedCoordinate = coordinate
                    }
                }
            }
            .navigationTitle("Set Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if let selectedCoordinate = selectedCoordinate {
                            friend.latitude = selectedCoordinate.latitude
                            friend.longitude = selectedCoordinate.longitude
                            try? modelContext.save()
                        }
                        dismiss()
                    }
                    .disabled(selectedCoordinate == nil)
                }
            }
        }
    }
}

#Preview {
    MapView(
        coordinate: CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784),
        friend: Friend(name: "Test Friend", photo: Data())
    )
}
