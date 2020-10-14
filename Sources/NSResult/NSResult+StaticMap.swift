//
//  NSResult+StaticMap.swift
//  NSResult
//
//  Created by Robert Armenski on 14.10.20.
//  Copyright © 2020 TitanTech. All rights reserved.
//

import Foundation

extension NSResult {
    /// Returns a new result, mapping any success or failure value to the given type.
    ///
    /// Use this method when you need to restore type-safety to an `NSResult` instance.
    ///
    /// - Parameter success: A success type
    /// - Parameter failure: An error type
    /// - Returns: A type-safe `Result` instance
    public func mapStatic<NewSuccess, NewFailure>(
        _: NewSuccess.Type,
        _: NewFailure.Type
    ) -> Result<NewSuccess, NewFailure> {
        self.base
        .map {
            guard let success = $0 as? NewSuccess else {
                fatalError("Invalid use of \(Self.self), \($0) is not a \(NewSuccess.self)")
            }
            return success
        }
        .mapError {
            guard let failure = $0 as? NewFailure else {
                fatalError("Invalid use of \(Self.self), \($0) is not a \(NewFailure.self)")
            }
            return failure
        }
    }
}
