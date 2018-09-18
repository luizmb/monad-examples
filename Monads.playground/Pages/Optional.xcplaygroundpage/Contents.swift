import Cocoa
//: [Previous](@previous)

/*:
 # Optional
 * Holds Value (or not)
 * Holds "boolean" state whether or not it holds value
 */

/*
enum Optional<A> {
    case some(A)
    case none
}
*/

let successString = Optional<String>.some("42")
let failureString = Optional<String>.none
let successInt = Optional<Int>.some(42)
let failureInt = Optional<Int>.none

//: ## Map

/*
extension Optional {
    func map<B>(_ transform: @escaping (A) -> B) -> Optional<B> {
        switch self {
        case let .some(a):
            let b = transform(a)
            return .some(b)
        case .none
            return .none
        }
    }
}
*/

// (Optional<String>) -> ((String) -> String) -> Optional<String>
successString.map { string in
    return "-- \(string) --"
}

// (Optional<String>) -> ((String) -> String) -> Optional<String>
failureString.map { string in
    return "-- \(string) --"
}

// (Optional<Int>) -> ((Int) -> String) -> Optional<String>
successInt.map { int in
    return String(int)
}

// (Optional<Int>) -> ((Int) -> String) -> Optional<String>
failureInt.map { int in
    return String(int)
}

//: [Next](@next)
//: - - -
//: ## FlatMap

/*
extension Optional {
//  func     map<B>(_ transform: @escaping (A) -> B          ) -> Optional<B> {
    func flatMap<B>(_ transform: @escaping (A) -> Optional<B>) -> Optional<B> {
        switch self {
        case let .some(a):
            let optionalB = transform(a)
            return optionalB
        case .none:
            return .none
        }
    }
}
*/

// (Optional<String>) -> ((String) -> Optional<String>) -> Optional<String>
successString.flatMap { string in
    return .some("-- \(string) --")
}

successString.flatMap { string in
    return Optional<String>.none
}

// (Optional<String>) -> ((String) -> Optional<String>) -> Optional<String>
failureString.flatMap { string in
    return .some("-- \(string) --")
}

failureString.flatMap { string in
    return Optional<String>.none
}

// (Optional<Int>) -> ((Int) -> Optional<String>) -> Optional<String>
successInt.flatMap { int in
    return .some(String(int))
}

successInt.flatMap { int in
    return Optional<String>.none
}

// (Optional<Int>) -> ((Int) -> Optional<String>) -> Optional<String>
failureInt.flatMap { int in
    return .some(String(int))
}

failureInt.flatMap { int in
    return Optional<String>.none
}

//: [Next](@next)
