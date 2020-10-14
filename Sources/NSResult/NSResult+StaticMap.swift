//
//  NSResult+StaticMap.swift
//  NSResult
//
//  Created by Robert Armenski on 14.10.20.
//  Copyright © 2020 TitanTech. All rights reserved.
//

import Foundation

extension NSResult {
    /// Returns a new result, casting any success or failure value to the given types.
    ///
    /// Use this method when you need to restore type-safety to an `NSResult` instance,
    /// by casting to types with __absolute__ certainty.
    ///
    /// - Parameter successType: A success type
    /// - Parameter failureType: An error type
    /// - Throws: A `fatalError` if the success value cannot be cast to the given type or
    ///   if the failure value cannot be cast to the given type
    /// - Returns: A type-safe `Result` instance with a success value of the new type
    ///   if this instance represents a success, or with a failure value of the new type
    ///   if this instance represents a failure.
    public func staticMap<NewSuccess, NewFailure>(
        _ successType: NewSuccess.Type,
        _ failureType: NewFailure.Type
    ) -> Result<NewSuccess, NewFailure> {
       self.base
           .staticMap(NewSuccess.self)
           .staticMapError(NewFailure.self)
    }

    /// Returns a new result, casting any success to the given type.
    ///
    /// Use this method when you need to restore type-safety to an `NSResult` instance,
    /// by casting to types with __absolute__ certainty.
    ///
    /// - Parameter successType: A success type
    /// - Throws: A `fatalError` if the success value cannot be cast to the given type
    /// - Returns: A type-safe `Result` instance with a success value of the new type
    ///   if this instance represents a success
    @inlinable public func staticMap<NewSuccess>(_ successType: NewSuccess.Type) -> Result<NewSuccess, Error> {
        self.staticMap(NewSuccess.self, Error.self)
    }
}
