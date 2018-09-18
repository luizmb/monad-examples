import Cocoa
//: [Previous](@previous)

/*:
 # Deferred
 * Holds an (async) operation that returns a Value in a completion handler
 * Holds the operation side-effect
 */

struct Deferred<A> {
    let run: (@escaping (A) -> Void) -> Void
}

let successString = Deferred<String> { completionHandler in completionHandler("42") }
let successInt = Deferred<Int> { completionHandler in completionHandler(42) }

//: ## Map

extension Deferred {
    func map<B>(_ transform: @escaping (A) -> B) -> Deferred<B> {
        return Deferred<B> { completionHandler in
            self.run { a in
                let b = transform(a)
                completionHandler(b)
            }
        }
    }
}

// (Deferred<String>) -> ((String) -> String) -> Deferred<String>
successString.map { string in
    return "-- \(string) --"
}.run { value in
    let a = value
    print(a)
}

// (Deferred<Int>) -> ((Int) -> String) -> Deferred<String>
successInt.map { int in
    return String(int)
}.run { value in
    let a = value
    print(a)
}

//: [Next](@next)
//: - - -
//: ## FlatMap

extension Deferred {
//  func     map<B>(_ transform: @escaping (A) -> B          ) -> Deferred<B> {
    func flatMap<B>(_ transform: @escaping (A) -> Deferred<B>) -> Deferred<B> {
        return Deferred<B> { completionHandlerB in
            self.run { a in
                let deferredB = transform(a)
                deferredB.run { b in
                    completionHandlerB(b)
                }
            }
        }
    }
}

// (Deferred<String>) -> ((String) -> Deferred<String>) -> Deferred<String>
successString.flatMap { string in
    return Deferred { completionHandler in completionHandler("-- \(string) --") }
}.run { value in
    let a = value
    print(a)
}

// (Deferred<Int>) -> ((Int) -> Deferred<String>) -> Deferred<String>
successInt.flatMap { int in
    return Deferred { completionHandler in completionHandler(String(int)) }
}.run { value in
    let a = value
    print(a)
}

//: - - -
//: ## Deferred in real life 1

/*
func delay(by duration: TimeInterval, line: UInt = #line, execute: @escaping () -> Void) {
    print("delaying line \(line) by \(duration)")
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
        execute()
        print("executed line \(line)")
    }
}

typealias Token = String
func login(user: String, password: String) -> Deferred<Token> {
    return Deferred { completionHandler in
        // let httpRequest =
        delay(by: 2) {
            let httpResponse = "This is a valid token"
            completionHandler(httpResponse)
        }
        // httpRequest.resume()
    }
}

typealias Device = String
func deviceList(token: Token) -> Deferred<[Device]> {
    return Deferred { completionHandler in
        print("making a device list request using this token => \(token)")
        // let httpRequest = operation with token = token
        delay(by: 2) {
            let httpResponse = ["One S", "One M", "Stereo M", "Streamer"]
            completionHandler(httpResponse)
        }
        // httpRequest.resume()
    }
}

login(user: "teufel", password: "raumfeld")
    .flatMap(deviceList)
    .run { devices in
        devices.forEach { print($0) }
    }
*/

//: - - -
//: ## Deferred in real life 2

/*
func deviceConcat(_ devices: [Device]) -> String {
    return devices.joined(separator: ", ")
}

login(user: "teufel", password: "raumfeld")
    .flatMap(deviceList)
    .map(deviceConcat)
    .run { devices in
        print(devices)
    }

 */

//: - - -
//: ## Deferred in real life 3

/*
func zip2<A, B>(_ fa: Deferred<A>, _ fb: Deferred<B>) -> Deferred<(A, B)> {
    return Deferred<(A, B)> { completionHandler in
        let group = DispatchGroup()
        var a: A?
        var b: B?

        group.enter()
        fa.run {
            a = $0
            group.leave()
        }

        group.enter()
        fb.run {
            b = $0
            group.leave()
        }

        group.notify(queue: .main) {
            completionHandler((a!, b!))
        }
    }
}

typealias Zone = String
func zoneList(token: Token) -> Deferred<[Zone]> {
    return Deferred { completionHandler in
        print("making a device list request using this token => \(token)")
        // let httpRequest = operation with token = token
        delay(by: 2) {
            let httpResponse = ["Living Room", "Garage", "Kitchen"]
            completionHandler(httpResponse)
        }
        // httpRequest.resume()
    }
}

login(user: "teufel", password: "raumfeld")
    .flatMap { zip2(deviceList(token: $0), zoneList(token: $0)) }
    .run { (devices, zones) in
        print("Devices: \(devices.joined(separator: ", "))")
        print("Zones: \(zones.joined(separator: ", "))")
    }
*/



/*:
 ## Important topics not covered:
 * Deferred Cancelation
 * Deferred Error Handling
 * Promises
 * Observable

 ## Conclusion

 ```
 Optional -> Result -> Deferred -> Promise -> Observable
                       Future
 ```

 ```
 Optional + Error handling = Result
 Deferred + Error handling = Promise
 Deferred + Result         = Promise
 Promise + multiple callbacks = Observable
 ```
 */
