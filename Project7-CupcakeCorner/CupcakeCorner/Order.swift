//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ahmet Büyükçelik on 19.08.2025.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    var streetAddress = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    var city = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    var zip = "" {
        didSet {
            saveToUserDefaults()
        }
    }
    
    var hasValidAdress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(name, forKey: "SavedName")
        UserDefaults.standard.set(streetAddress, forKey: "SavedStreetAddress")
        UserDefaults.standard.set(city, forKey: "SavedCity")
        UserDefaults.standard.set(zip, forKey: "SavedZip")
    }

    private func loadFromUserDefaults() {
        let savedName = UserDefaults.standard.string(forKey: "SavedName") ?? ""
        let savedStreet = UserDefaults.standard.string(forKey: "SavedStreetAddress") ?? ""
        let savedCity = UserDefaults.standard.string(forKey: "SavedCity") ?? ""
        let savedZip = UserDefaults.standard.string(forKey: "SavedZip") ?? ""
        
        self.name = savedName
        self.streetAddress = savedStreet
        self.city = savedCity
        self.zip = savedZip
    }
    
    init() {
        loadFromUserDefaults()
    }
}
