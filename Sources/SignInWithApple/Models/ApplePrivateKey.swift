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

    /// Creates a struct to represent your Sign in with Apple private key. The key must be registered in the developer
    /// portal with the Sign in with Apple service enabled.
    ///
    /// - parameter kid: This is the key identifier, which can be found in the developer portal.
    /// - parameter key: This is an `ECDSAKey` containing the contents of the key itself. Call `ECDSAKey.private(pem:)` with your key contents.
    ///
    /// Register a new key on the developer portal [here](https://developer.apple.com/account/resources/authkeys/list).
    public init(
        kid: JWKIdentifier,
        key: ECDSAKey
    ) {
        self.kid = kid
        self.key = key
    }

    /// Creates a struct to represent your Sign in with Apple private key. The key must be registered in the developer
    /// portal with the Sign in with Apple service enabled.
    ///
    /// - parameter kid: This is the key identifier, which can be found in the developer portal.
    /// - parameter privateKey: This is the contents of the key itself, in `String` form.
    ///
    /// Register a new key on the developer portal [here](https://developer.apple.com/account/resources/authkeys/list).
    public init(
        kid: JWKIdentifier,
        privateKey: String
    ) throws {
        self.kid = kid
        self.key = try ECDSAKey.private(pem: privateKey)
    }
}
