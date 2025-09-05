//
//  Friend.swift
//  Challenge5FriendFace
//
//  Created by Ahmet Büyükçelik on 22.08.2025.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        
        self.init(id: id, name: name)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
