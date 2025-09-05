//
//  Prospect.swift
//  HotProspects
//
//  Created by Ahmet Büyükçelik on 27.08.2025.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var dateAdded: Date?
    
    init(name: String, emailAddress: String, isContacted: Bool, dateAdded: Date? = Date()) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.dateAdded = dateAdded
    }
}
