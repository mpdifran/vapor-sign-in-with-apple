//
//  AppleTokenGenerationDetails.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import JWT

public struct AppleTokenGenerationDetails {
    public let teamIdentifier: String
    public let appIdentifier: String
    public let identityToken: String
    public let authorizationCode: String
    public let redirectURI: URL?
    public let privateKey: ApplePrivateKey

    /// Creates a struct to hold the details needed to generate tokens from Apple's servers.
    /// - parameter teamIdentifier: This is your team identifier, which can be found in the developer portal.
    /// - parameter appIdentifier: This is your app's Bundle ID, or your registered Service ID.
    /// - parameter identityToken: This is obtained from the credentials after the user has authenticated on the client.
    /// - parameter authorizationCode: This is obtained from the credentials after the user has authenticated on the
    /// client.
    /// - parameter redirectURI: The destination URI provided in the authorization request when authorizing a user with
    /// your app, if applicable.
    /// - parameter privateKey: The private key you've registered in the developer portal.
    public init(teamIdentifier: String,
                appIdentifier: String,
                identityToken: String,
                authorizationCode: String,
                redirectURI: URL? = nil,
                privateKey: ApplePrivateKey) {
        self.teamIdentifier = teamIdentifier
        self.appIdentifier = appIdentifier
        self.identityToken = identityToken
        self.authorizationCode = authorizationCode
        self.redirectURI = redirectURI
        self.privateKey = privateKey
    }
}
