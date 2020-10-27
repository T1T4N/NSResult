//
//  Result+StaticMap.swift
//  NSResult
//
//  Created by Robert Armenski on 14.10.20.
//  Copyright © 2020 TitanTech. All rights reserved.
//

import Foundation

extension Result {
    /// Returns a new result, casting any success value to the given type.
    ///
    /// Use this method when you need to cast the value of a `Result`
    /// instance when it represents a success, to a type with __absolute__ certainty.
    ///
    /// The following example transforms the integer success value of a result into an NSNumber:
    ///
    ///     func getNextInteger() -> Result<Int, Error> { /* ... */ }
    ///
    ///     let integerResult = getNextInteger()
    ///     // integerResult == .success(5)
    ///     let nsNumberResult = integerResult.staticMap(NSNumber.self)
    ///     // nsNumberResult == .success(5) // of type NSNumber
    ///
    /// - Parameter successType: A success type
    /// - Throws: A `fatalError` if the success value cannot be cast to the given type
    /// - Returns: A `Result` instance with the success value cast to the new type
    ///   if this instance represents a success.
    public func staticMap<NewSuccess>(_ successType: NewSuccess.Type) -> Result<NewSuccess, Failure> {
        self.map {
            guard let success = $0 as? NewSuccess else {
                fatalError("Invalid use of \(Self.self), \($0) is not a \(NewSuccess.self)")
            }
            return success
        }
    }

    /// Returns a new result, casting any failure value to the given type.
    ///
    /// Use this method when you need to cast the value of a `Result`
    /// instance when it represents a failure, to a type with __absolute__ certainty.
    ///
    /// The following example transforms the error value of a result by wrapping it in a custom `Error` type:
    ///
    ///     struct DatedError: Error {
    ///         var error: Error
    ///         var date: Date
    ///
    ///         init(_ error: Error) {
    ///             self.error = error
    ///             self.date = Date()
    ///         }
    ///     }
    ///
    ///     let result: Result<Int, Error> = // ...
    ///     // result == .failure(<error value>)
    ///     let resultWithDatedError = result.staticMapError(DatedError.self)
    ///     // result == .failure(DatedError(error: <error value>, date: <date>))
    ///
    /// - Parameter failureType: An error type
    /// - Throws: A `fatalError` if the failure value cannot be cast to the given type
    /// - Returns: A `Result` instance with the failure value cast to the new type
    ///   if this instance represents a failure.
    public func staticMapError<NewFailure>(_ failureType: NewFailure.Type) -> Result<Success, NewFailure> {
        self.mapError {
            guard let failure = $0 as? NewFailure else {
                fatalError("Invalid use of \(Self.self), \($0) is not a \(NewFailure.self)")
            }
            return failure
        }
    }
}
