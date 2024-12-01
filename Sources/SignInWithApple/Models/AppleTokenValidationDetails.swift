//
//  AppleTokenValidationDetails.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation

public struct AppleTokenValidationDetails: Sendable {
    public let teamIdentifier: String
    public let appIdentifier: String
    public let identityToken: String
    public let refreshToken: String
    public let privateKey: ApplePrivateKey

    /// Creates a struct to hold the details needed to generate tokens from Apple's servers.
    /// - parameter teamIdentifier: This is your team identifier, which can be found in the developer portal.
    /// - parameter appIdentifier: This is your app's Bundle ID, or your registered Service ID.
    /// - parameter identityToken: This is obtained from the credentials after the user has authenticated on the client.
    /// your app, if applicable.
    /// - parameter refreshToken: The refresh token you've previously obtained from `Request.generateTokens`.
    /// - parameter privateKey: The private key you've registered in the developer portal.
    public init(teamIdentifier: String,
                appIdentifier: String,
                identityToken: String,
                refreshToken: String,
                privateKey: ApplePrivateKey) {
        self.teamIdentifier = teamIdentifier
        self.appIdentifier = appIdentifier
        self.identityToken = identityToken
        self.refreshToken = refreshToken
        self.privateKey = privateKey
    }
}
