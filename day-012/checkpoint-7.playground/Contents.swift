class Animal {
    fileprivate let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak(){}
}

class Dog: Animal {
    
    init() {
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Dog")
    }
    
}

class Corgi: Dog {
    override func speak() {
        print("Corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Poodle")
    }
}

class Cat: Animal {
    fileprivate var isTame: Bool
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    override func speak() {
        print("Cat")
    }
}

class Persian: Cat {
    init() {
        super.init(isTame: true)
    }
    override func speak() {
        print("Persian")
    }
}

class Lion: Cat {
    init() {
        super.init(isTame: false)
    }
    override func speak() {
        print("Lion")
    }
}

let poodle = Poodle()
poodle.speak()
