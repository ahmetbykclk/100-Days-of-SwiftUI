import UIKit

protocol building {
    var roomCount: Int { get set }
    var cost: Int { get set }
    var estateAgentName: String { get set }
    func salesSummary ()
}

struct House: building {
    var roomCount: Int
    var cost: Int
    var estateAgentName: String
    
    func salesSummary () {
        print("This house has \(roomCount) rooms and costs \(cost)")
    }
}

struct Office: building {
    var roomCount: Int
    var cost: Int
    var estateAgentName: String
    
    func salesSummary () {
        print("This office has \(roomCount) rooms and costs \(cost)")
    }
}
let office1 = Office(roomCount: 4, cost: 20000, estateAgentName: "Example Estate Agent")
let house1 = House(roomCount: 2, cost: 10000, estateAgentName: "Example Estate Agent")

office1.salesSummary()
house1.salesSummary()
