//
//  ErrorType.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

enum ErrorType {
    case invalidResponse
    case apiFailure(failure: Error?)
    
    var errorDescription: String {
        switch self {
        case .invalidResponse:
            return "invalid Response"
        case .apiFailure(failure: let error):
            return error.debugDescription
        }
    }
}
