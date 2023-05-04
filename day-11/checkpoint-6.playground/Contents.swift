struct Car {
    fileprivate let model: String
    fileprivate let numberOfSeats: Int
    fileprivate var currentGear: Int = 1
    
    mutating func gearUp() {
        if self.currentGear == 10 {
            return
        }
        
        self.currentGear += 1
    }
    
    mutating func gearDown() {
        if self.currentGear == 1 {
            return
        }
        
        self.currentGear -= 1
    }
}

var car = Car(model: "Honda S2000", numberOfSeats: 2)
print(car)
car.gearDown()
print(car)
car.gearUp()
print(car)
