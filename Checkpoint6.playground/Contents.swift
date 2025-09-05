import UIKit

struct Car {
    let model: String
    let numberOfSeats: Int
    var currentGear = 1
    
    mutating func changeGear(_ newGear: Int) {
        if newGear < 1 || newGear > 6 {
            print("Invalid gear selection")
        } else {
            currentGear = newGear
        }
    }
}

var myCar = Car(model: "Nissan GT-R R35", numberOfSeats: 2)
print(myCar)
myCar.currentGear = 6
print(myCar)
