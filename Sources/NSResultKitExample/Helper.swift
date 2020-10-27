//
//  Helper.swift
//  NSResultKitExample
//
//  Created by Robert Armenski on 27.10.20.
//

import Foundation
import NSResultKit

enum RandomError: Error {
    case oddNumberFailure(Int)
}

extension RandomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .oddNumberFailure(let number):
            return "Number \(number) is odd"
        @unknown default:
            return "Unknown"
        }
    }
}

@objc(Helper)
public class Helper: NSObject {
    @objc public static func process(_ result: NSResult) {
        switch result.base {
        case .success(let value):
            print("Sucess: \(value)")
        case .failure(let error):
            print("Failure: \(error)")
        }
    }

    static var random: Result<Int, RandomError> {
        let val = Int.random(in: 0...100)
        return val.isMultiple(of: 2) ? .success(val) : .failure(.oddNumberFailure(val))
    }

    @objc public static func randomResult() -> NSResult {
        .init(random)
    }
}
