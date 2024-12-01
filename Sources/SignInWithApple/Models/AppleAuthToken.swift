//
//  AppleAuthToken.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor
@preconcurrency import JWT

struct AppleAuthToken: JWTPayload, Sendable {
    let iss: String
    let iat: Int
    let exp: Int
    let aud: String
    let sub: String

    /// Creates an auth token to send to Apple's servers.
    ///
    /// - parameter clientId: Your app's Bundle ID, or your registered Service ID.
    /// - parameter teamId: Your team identifier, which can be found in the developer portal.
    /// - parameter expirationSeconds: How many seconds until this token expires.
    init(
        clientId: String,
        teamId: String,
        expirationSeconds: Int = 86400 * 180
    ) {
        iss = teamId
        iat = Int(Date().timeIntervalSince1970)
        exp = self.iat + expirationSeconds
        aud = "https://appleid.apple.com"
        sub = clientId
    }

    func verify(using signer: JWTSigner) throws {
        guard iss.count == 10 else {
            throw JWTError.claimVerificationFailure(name: "iss", reason: "TeamId must be your 10-character Team ID from the developer portal")
        }

        let lifetime = exp - iat
        guard 0...15777000 ~= lifetime else {
            throw JWTError.claimVerificationFailure(name: "exp", reason: "Expiration must be between 0 and 15777000")
        }
    }
}
