//
//  Friend.swift
//  Challenge6FriendName
//
//  Created by Ahmet Büyükçelik on 26.08.2025.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Friend {
    var name: String
    @Attribute(.externalStorage) var photo: Data
    var latitude: Double?
    var longitude: Double?
    
    init(name: String, photo: Data, latitude: Double? = nil, longitude: Double? = nil) {
        self.name = name
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}
