protocol Building {
    
    var numberOfRooms: Int { get }
    var cost: Int { get }
    var estateAgent: String { get }
    
    func printSalesSummary()
    
}

struct House: Building {
    var numberOfRooms: Int
    
    var cost: Int
    
    var estateAgent: String
    
    func printSalesSummary() {
    }
    
    
}

struct Office: Building {
    var numberOfRooms: Int
    
    var cost: Int
    
    var estateAgent: String
    
    func printSalesSummary() {
    }
}

extension Numeric {
    func squared() -> Self {
        self * self
    }
}

let wholeNumber = 5
print(wholeNumber.squared())

struct User: Comparable {
    let name: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}

let user1 = User(name: "Taylor")
let user2 = User(name: "Adele")

print(user1 < user2)
print(user1 <= user2)
print(user1 > user2)
print(user1 >= user2)


