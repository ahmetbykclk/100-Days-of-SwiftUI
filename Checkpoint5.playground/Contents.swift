import UIKit

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let _ = luckyNumbers
    .filter { $0.isMultiple(of: 2)}
    .sorted()
    .map { print ("\($0) is a lucky number") }

//let evenLuckyNumbers = luckyNumbers.filter { $0 % 2 == 0 }
//let ascendingEvenLuckyNumbers = evenLuckyNumbers.sorted()
//let isALuckyNumberAscendingEvenLuckyNumbers = ascendingEvenLuckyNumbers.map { string in
//    "\(string) is a lucky number"
//}
//for item in isALuckyNumberAscendingEvenLuckyNumbers {
//    print(item)
//}
