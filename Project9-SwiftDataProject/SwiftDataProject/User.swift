//
//  User.swift
//  SwiftDataProject
//
//  Created by Ahmet Büyükçelik on 21.08.2025.
//

import Foundation
import SwiftData

@Model
class User {
    var name = "Anonymous"
    var city = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs:  [Job]? = [Job]()
    
    var unwrappedJobs: [Job] {
        jobs ?? []
    }
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
