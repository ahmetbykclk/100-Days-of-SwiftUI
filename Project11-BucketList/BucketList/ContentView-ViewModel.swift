//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Ahmet Büyükçelik on 24.08.2025.
//

import Foundation
import MapKit
import CoreLocation
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
        var mapType: MKMapType = .standard
        var authenticationError: String?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        if let error = authenticationError {
                            self.authenticationError = error.localizedDescription
                        } else {
                            self.authenticationError = "Authentication failed"
                        }
                    }
                }
            } else {
                if let error = error {
                    self.authenticationError = error.localizedDescription
                } else {
                    self.authenticationError = "Biometric authentication not available"
                }
            }
        }
        func toggleMapType() {
            mapType = mapType == .standard ? .hybrid : .standard
        }
    }
}
