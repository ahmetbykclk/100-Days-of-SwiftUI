//
//  Location.swift
//  BucketList
//
//  Created by Ahmet Büyükçelik on 24.08.2025.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(
        id: UUID(),
        name: "Istanbul",
        description: "Istanbul is a beautiful city",
        latitude: 41.015137,
        longitude: 28.979530
    )
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
