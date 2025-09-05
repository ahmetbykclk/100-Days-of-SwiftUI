import UIKit

func randomInt(intArray: [Int]?) -> Int {
    intArray?.randomElement() ?? Int.random(in: 1...100)
}

print(randomInt(intArray: []))

print(randomInt(intArray: [1, 2, 3]))

