import UIKit

enum sqrtError: Error {
    case outOfBounds, noRoot
}

func squareRoot(_ number: Int) throws -> Int  {
    var isThereARoot = false
    if number <= 0 || number > 10000 {
        throw sqrtError.outOfBounds
    }
    for i in 1...100 {
        if i * i == number {
            isThereARoot = true
            return i
        }
    }
    if !isThereARoot {
        throw sqrtError.noRoot
    }
}
do {
    print(try squareRoot(20))
} catch sqrtError.outOfBounds {
    print("Number is out of bounds")
} catch sqrtError.noRoot {
    print("No root")
}
