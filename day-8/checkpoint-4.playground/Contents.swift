enum SqrtErros: Error {
    case OutOfBounds
    case NoRoot
}


func squareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10000 {
        throw SqrtErros.OutOfBounds
    }

    for n in 1..<number / 2 {
        if n * n == number {
            return n
        }
    }
    
    throw SqrtErros.NoRoot
}

let n = 7
do {
    let result = try squareRoot(of: n)
    print("Number \(n) has square root of \(result).")
} catch SqrtErros.OutOfBounds {
    print("Number \(n) must be between [1, 10000].")
} catch SqrtErros.NoRoot {
    print("Number \(n) has no integer square root.")
}

