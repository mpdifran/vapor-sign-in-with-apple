//
//  ApplePrivateKey.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
@preconcurrency import JWT

public struct ApplePrivateKey: Sendable {
    public let kid: JWKIdentifier
    public let key: ECDSAKey

    /// Creates a struct to represent your Sign in with Apple private key. he key must be registered in the developer
    /// portal with the Sign in with Apple service enabled.
    ///
    /// - parameter kid: This is the key identifier, which can be found in the developer portal.
    /// - parameter key: This is the contents of the key itself.
    ///
    /// Register a new key on the developer portal [here](https://developer.apple.com/account/resources/authkeys/list).
    public init(kid: JWKIdentifier,
                key: ECDSAKey) {
        self.kid = kid
        self.key = key
    }
}
