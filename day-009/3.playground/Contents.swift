func makeArray(size: Int, using generator: (Int) -> Int) -> [Int] {
    var numbers = [Int]()

    for i in 0..<size {
        let newNumber = generator(i)
        numbers.append(newNumber)
    }

    return numbers
}

let rolls = makeArray(size: 50) { $0 * 2 }

print(rolls)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}
