//
//  Request+SignInWithApple.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor
import JWT

// MARK: - Public Methods

public extension Request {

    /// Generates access and refresh tokens by verifying the provided identity token, validating an authorization grant
    /// code, and performing an exchange with Apple's servers.
    ///
    /// - parameter details: The details required to generate tokens.
    ///
    /// Further reading [Generate and Validate Tokens Documentation](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
    func generateAppleTokens(details: AppleTokenGenerationDetails) throws -> EventLoopFuture<AppleTokenResponse> {
        return try jwt.apple.verify(details.identityToken, applicationIdentifier: details.appIdentifier)
            .sendTokenGenerationRequest(client: client, details: details)
            .parseAppleTokenResponse()
    }

    /// Validates an existing refresh token with Apple's servers, obtaining a new access token.
    ///
    /// - parameter details: The details required to validate tokens.
    ///
    /// Further reading [Generate and Validate Tokens Documentation](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
    func validateAppleTokens(details: AppleTokenValidationDetails) throws -> EventLoopFuture<AppleTokenResponse> {
        return try jwt.apple.verify(details.identityToken, applicationIdentifier: details.appIdentifier)
            .sendTokenValidationRequest(client: client, details: details)
            .parseAppleTokenResponse()
    }
}

// MARK: - Internal Methods

extension EventLoopFuture where Value == AppleIdentityToken {

    func sendTokenGenerationRequest(client: Client,
                                    details: AppleTokenGenerationDetails) throws -> EventLoopFuture<ClientResponse> {
        let authToken = AppleAuthToken(clientId: details.appIdentifier, teamId: details.teamIdentifier)

        let signer = JWTSigner.es256(key: details.privateKey.key)
        let clientSecret = try signer.sign(authToken, kid: details.privateKey.kid)

        let body = AppleTokenRequest(clientId: details.appIdentifier,
                                     clientSecret: clientSecret,
                                     code: details.authorizationCode,
                                     redirectUri: details.redirectURI)

        return try client.postTokenRequest(body: body)
    }

    func sendTokenValidationRequest(client: Client,
                                    details: AppleTokenValidationDetails) throws -> EventLoopFuture<ClientResponse> {
        let authToken = AppleAuthToken(clientId: details.appIdentifier, teamId: details.teamIdentifier)

        let signer = JWTSigner.es256(key: details.privateKey.key)
        let clientSecret = try signer.sign(authToken, kid: details.privateKey.kid)

        let body = AppleTokenRequest(clientId: details.appIdentifier,
                                     clientSecret: clientSecret,
                                     refreshToken: details.refreshToken)

        return try client.postTokenRequest(body: body)
    }
}

extension EventLoopFuture where Value == ClientResponse {

    func parseAppleTokenResponse() -> EventLoopFuture<AppleTokenResponse> {
        flatMapThrowing { (response) -> AppleTokenResponse in
            if let error = response.parseAppleErrorResponse() {
                throw error
            }

            return try response.content.decode(AppleTokenResponse.self)
        }
    }
}

extension ClientResponse {

    func parseAppleErrorResponse() -> Error? {
        do {
            let error = try content.decode(AppleErrorResponse.self)
            return NSError(domain: "Vapor - Sign in with Apple",
                           code: 0,
                           userInfo: [NSLocalizedDescriptionKey : error.error])
        } catch { }

        return nil
    }
}
