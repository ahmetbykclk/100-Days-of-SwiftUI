import UIKit

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak(){
        print("Woof!")
    }
    init() {
        super.init(legs: 4)
    }
}

class Corgi: Dog {
    override func speak() {
        print("Yip!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Squeak!")
    }
}

class Cat: Animal {
    var isTame: Bool {
        return true
    }
    init() {
        super.init(legs: 4)
    }
    func speak() {
        print("Meow!")
    }
}

class Lion: Cat {
    override var isTame: Bool {
        return false
    }
    override func speak() {
        print("ROARRR!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meeeoooooww")
    }
}

var dog1 = Dog()
dog1.speak()

var corgi1 = Corgi()
corgi1.speak()

var poodle1 = Poodle()
poodle1.speak()

var cat1 = Cat()
cat1.speak()

var lion1 = Lion()
lion1.speak()
lion1.isTame

var persian1 = Persian()
persian1.speak()
persian1.isTame

