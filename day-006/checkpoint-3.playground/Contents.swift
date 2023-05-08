
for n in 1...100 {
 
    var result = ""
    
    if n.isMultiple(of: 3) {
        result += "Fizz"
    }
    
    if n.isMultiple(of: 5) {
        result += "Buzz"
    }
    
    if result.isEmpty {
        print("\(n)")
        continue
    }
    
    print(result)
}

