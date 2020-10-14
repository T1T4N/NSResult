import Foundation
import NSResultKit

//: # Getting started
//: Wrapping a result for accessing in Objective-C code
let stringResult: Result<String, Never> = .success("Example")
let nsResult = NSResult(stringResult)

enum ExampleError: Error {
    case requestFailed(_ code: Int)
}

let errorResult: Result<String, ExampleError> = .failure(.requestFailed(666))
let nsErrorResult = NSResult(errorResult)

//: # Restoring type safety
//: As generic Swift classes aren't representable in Objective-C, data in `NSResult` must have its type information erased, leaving us with `Result<Any, Error>`.
//:
//: For the purpose of easy interopability and reducing boilerplate code, `NSResult` has the method `staticMap`.
//:
//: __Important__: This function should __only__ be used in a controlled environment where the developer is __certain__ of the type that is sent. `staticMap` performs a simple `as?` cast and will fail with a `fatalError` if that is not possible.
let typesafeResult1 = nsResult.staticMap(String.self, Never.self)
type(of: typesafeResult1) // Result<String, Never>
print(typesafeResult1)

//: This is fine as `Never` is a special type of `Error`
let typesafeResult2 = nsResult.staticMap(String.self, Error.self)
type(of: typesafeResult2) // Result<String, Error>
print(typesafeResult2)

let typesafeResult3 = nsErrorResult.staticMap(Any.self, ExampleError.self)
type(of: typesafeResult3) // Result<Any, ExampleError>
print(typesafeResult3)

//: Every error is implicitly bridgable to `NSError`
let typesafeResult4 = nsErrorResult.staticMap(Any.self, NSError.self)
type(of: typesafeResult4) // Result<Any, NSError>
print(typesafeResult4)

//: For scenarios where type transformation might fail, `Result`'s `map/flatMap`  should be used.
let manualTypeCastResult = nsResult.base.map { (value: Any) -> Int in
    Int("\(value)") ?? -1
}
type(of: manualTypeCastResult)
print(manualTypeCastResult)

//: This results in a `fatalError` as `String` is not directly castable to `Int`.
let typecastFailure1 = nsResult.staticMap(Int.self, Error.self)

//: This results in a `fatalError` as `Error` is not castable to `Never`.
let typecastFailure2 = nsErrorResult.staticMap(Int.self, Never.self)
