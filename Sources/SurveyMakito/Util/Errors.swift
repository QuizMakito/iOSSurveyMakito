//
//  File.swift
//
//
//  Created by Kris Steigerwald on 3/17/23.
//

import Foundation

enum SurveyError: Error {
    // Throw when an invalid password is entered
    case keyIsEmpty

    // Throw when an expected resource is not found
    case notFound

    // Throw in all other cases
    case unexpected(code: Int)
}

extension SurveyError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .keyIsEmpty:
            return "UID Key can not be empty."
        case .notFound:
            return "The specified item could not be found."
        case .unexpected:
            return "An unexpected error occurred."
        }
    }
}
