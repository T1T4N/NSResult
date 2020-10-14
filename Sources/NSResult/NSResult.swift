//
//  NSResult.swift
//  NSResult
//
//  Created by Robert Armenski on 14.10.20.
//  Copyright © 2020 TitanTech. All rights reserved.
//

import Foundation

@objc(NSResult)
public final class NSResult: NSObject {
    public let base: Result<Any, Error>

    public init(erased base: Result<Any, Error>) {
        self.base = base
    }

    @objc
    public convenience init(value: Any) {
        self.init(erased: .success(value))
    }

    @objc
    public convenience init(error: Error) {
        self.init(erased: .failure(error))
    }
}

// MARK: - Convenience Objective-C functionality
extension NSResult {
    @objc
    public static func success(_ value: Any) -> Self {
        .init(value: value)
    }

    @objc
    public static func failure(_ error: Error) -> Self {
        .init(error: error)
    }

    @objc
    public convenience init(domain: String, code: Int, userInfo dict: [String: Any]? = nil) {
        self.init(error: NSError(domain: domain, code: code, userInfo: dict))
    }
}

// MARK: - Convenience Swift functionality
extension NSResult {
    public convenience init<Success, Failure: Error>(_ base: Result<Success, Failure>) {
        self.init(erased: base.map { $0 as Any }.mapError { $0 as Error })
    }
}
