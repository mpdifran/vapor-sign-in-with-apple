//
//  AppleErrorResponse.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor

/// The repsonse Apple sends when there was an error generating tokens.
/// - note: [ErrorResponse Documentation](https://developer.apple.com/documentation/sign_in_with_apple/errorresponse)
struct AppleErrorResponse: Decodable, Equatable, Content {
    let error: String
}
