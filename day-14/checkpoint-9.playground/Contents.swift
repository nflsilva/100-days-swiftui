
func doWork(data: [Int]?) -> Int {
    return data?.randomElement() ?? Int.random(in: 1...100)
}

print(doWork(data: nil))
print(doWork(data: []))
print(doWork(data: [1]))
