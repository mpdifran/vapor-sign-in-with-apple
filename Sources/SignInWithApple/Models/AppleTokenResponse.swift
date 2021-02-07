//
//  AppleTokenResponse.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor

/// The response Apple sends when generating tokens.
/// - note: [TokenResponse Documentation](https://developer.apple.com/documentation/sign_in_with_apple/tokenresponse)
public struct AppleTokenResponse: Decodable, Equatable, Content {
    /// (Reserved for future use) A token used to access allowed data. Currently, no data set has been defined for
    /// access.
    public let accessToken: String

    /// The amount of time, in seconds, before the access token expires.
    public let expiresIn: TimeInterval

    /// A JSON Web Token that contains the user’s identity information.
    public let idToken: String

    /// The refresh token used to regenerate new access tokens. Store this token securely on your server.
    public let refreshToken: String

    /// The type of access token. It will always be bearer.
    public let tokenType: String
}
