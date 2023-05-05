var quote: String = "   The truth is rarely pure and never simple   "
let trimmed = quote.replacing(" ", with: "")

extension String {
    func trimmed() -> String {
        self.replacing(" ", with: "")
    }
    mutating func trim() {
        self = self.trimmed()
    }
}

let trim = quote.trimmed()
print(trim)
