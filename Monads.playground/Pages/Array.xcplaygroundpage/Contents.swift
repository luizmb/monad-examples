import Cocoa
//: [Previous](@previous)

/*:
 # Array
 * Holds Values (or not)
 * Holds "count" state of how many values are held
 */

/*
class Array<A> {
    var count: Int
    ...
}
*/

let successString = Array<String>.init(arrayLiteral: "1", "2", "3", "4")
let failureString = Array<String>.init()
let successInt = Array<Int>.init(arrayLiteral: 1, 2, 3, 4)
let failureInt = Array<Int>.init()

//: ## Map

/*
extension Array {
    func map<B>(_ transform: @escaping (A) -> B) -> Array<B> {
        var arrayOfB: [B] = []
        for a in self {
            let b = transform(a)
            arrayOfB.append(b)
        }
        return arrayOfB
    }
}
*/

// (Array<String>) -> ((String) -> String) -> Array<String>
successString.map { string in
    return "-- \(string) --"
}

// (Array<String>) -> ((String) -> String) -> Array<String>
failureString.map { string in
    return "-- \(string) --"
}

// (Array<Int>) -> ((Int) -> String) -> Array<String>
successInt.map { int in
    return String(int)
}

// (Array<Int>) -> ((Int) -> String) -> Array<String>
failureInt.map { int in
    return String(int)
}

//: [Next](@next)
//: - - -
//: ## FlatMap

/*
extension Array {
//  func     map<B>(_ transform: @escaping (A) -> B       ) -> Array<B> {
    func flatMap<B>(_ transform: @escaping (A) -> Array<B>) -> Array<B> {
        var arrayOfB: [B] = []
        for a in self {
            let arrayOfBInternal = transform(a)
            for b in arrayOfBInternal {
                arrayOfB.append(b)
            }
        }
    }
}
*/

// (Array<String>) -> ((String) -> Array<String>) -> Array<String>
successString.flatMap { string in
    return ["1 -- \(string) --", "2 -- \(string) --", "3 -- \(string) --"]
}

// (Array<String>) -> ((String) -> Array<String>) -> Array<String>
failureString.flatMap { string in
    return ["1 -- \(string) --", "2 -- \(string) --", "3 -- \(string) --"]
}

// (Array<Int>) -> ((Int) -> Array<String>) -> Array<String>
successInt.flatMap { int in
    return ["1 -- \(int) --", "2 -- \(int) --", "3 -- \(int) --"]
}

// (Array<Int>) -> ((Int) -> Array<String>) -> Array<String>
failureInt.flatMap { int in
    return ["1 -- \(int) --", "2 -- \(int) --", "3 -- \(int) --"]
}

//: [Next](@next)
