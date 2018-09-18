import Cocoa
struct AnyError: Error {}

//: [Previous](@previous)

/*:
 # Result
 * Holds Value (or error)
 * Holds "boolean" state whether or not it holds value
 */

enum Result<A, E> {
    case success(A)
    case failure(E)
}

let successString = Result<String, Error>.success("42")
let failureString = Result<String, Error>.failure(AnyError())
let successInt = Result<Int, Error>.success(42)
let failureInt = Result<Int, Error>.failure(AnyError())

//: ## Map

extension Result {
    func map<B>(_ transform: @escaping (A) -> B) -> Result<B, E> {
        switch self {
        case let .success(a):
            let b = transform(a)
            return .success(b)
        case let .failure(e):
            return .failure(e)
        }
    }
}

// (Result<String, Error>) -> ((String) -> String) -> Result<String, Error>
successString.map { string in
    return "-- \(string) --"
}

// (Result<String, Error>) -> ((String) -> String) -> Result<String, Error>
failureString.map { string in
    return "-- \(string) --"
}

// (Result<Int, Error>) -> ((Int) -> String) -> Result<String, Error>
successInt.map { int in
    return String(int)
}

// (Result<Int, Error>) -> ((Int) -> String) -> Result<String, Error>
failureInt.map { int in
    return String(int)
}

//: [Next](@next)
//: - - -
//: ## FlatMap

extension Result {
//  func     map<B>(_ transform: @escaping (A) -> B           ) -> Result<B, E> {
    func flatMap<B>(_ transform: @escaping (A) -> Result<B, E>) -> Result<B, E> {
        switch self {
        case let .success(a):
            let resultOfB = transform(a)
            return resultOfB
        case let .failure(e):
            return .failure(e)
        }
    }
}

// (Result<String, Error>) -> ((String) -> Result<String, Error>) -> Result<String, Error>
successString.flatMap { string in
    return .success("-- \(string) --")
}

successString.flatMap { string in
    return Result<String, Error>.failure(AnyError())
}

// (Result<String, Error>) -> ((String) -> Result<String, Error>) -> Result<String, Error>
failureString.flatMap { string in
    return .success("-- \(string) --")
}

failureString.flatMap { string in
    return Result<String, Error>.failure(AnyError())
}

// (Result<Int, Error>) -> ((Int) -> Result<String, Error>) -> Result<String, Error>
successInt.flatMap { int in
    return .success(String(int))
}

successInt.flatMap { int in
    return Result<String, Error>.failure(AnyError())
}

// (Result<Int, Error>) -> ((Int) -> Result<String, Error>) -> Result<String, Error>
failureInt.flatMap { int in
    return .success(String(int))
}

failureInt.flatMap { int in
    return Result<String, Error>.failure(AnyError())
}

//: [Next](@next)
