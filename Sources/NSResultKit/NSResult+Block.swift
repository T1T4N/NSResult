//
//  NSResult+Block.swift
//  NSResult
//
//  Created by Robert Armenski on 14.10.20.
//  Copyright © 2020 TitanTech. All rights reserved.
//

import Foundation

extension NSResult {
    @objc
    public func performBlock(_ block: (Any?, Error?) -> Void) {
        switch self.base {
        case .success(let value):
            block(value, nil)
        case .failure(let error):
            block(nil, error)
        }
    }

    @objc(performSuccess:orFailure:)
    public func perform(success: (Any) -> Void, failure: (Error) -> Void) {
        switch self.base {
        case .success(let value):
            success(value)
        case .failure(let error):
            failure(error)
        }
    }
}
