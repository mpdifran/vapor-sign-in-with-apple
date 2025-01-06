//
//  Request+SignInWithApple.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor
@preconcurrency import JWT

public extension Request {
    var signInWithApple: Request.SignInWithApple {
        .init(request: self)
    }

    struct SignInWithApple {
        let request: Request
    }
}

// MARK: - Public Methods

public extension Request.SignInWithApple {

    /// Generates access and refresh tokens by verifying the provided identity token, validating an authorization grant
    /// code, and performing an exchange with Apple's servers.
    ///
    /// - parameter details: The details required to generate tokens.
    ///
    /// Further reading [Generate and Validate Tokens Documentation](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
    func generateAppleTokens(details: AppleTokenGenerationDetails) async throws -> AppleTokenResponse {
        let _ = try await request.jwt.apple.verify(details.identityToken, applicationIdentifier: details.appIdentifier).get()
        return try await sendTokenGenerationRequest(details: details)
    }

    /// Validates an existing refresh token with Apple's servers, obtaining a new access token.
    ///
    /// - parameter details: The details required to validate tokens.
    ///
    /// Further reading [Generate and Validate Tokens Documentation](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
    func validateAppleTokens(details: AppleTokenValidationDetails) async throws -> AppleTokenResponse {
        let _ = try await request.jwt.apple.verify(details.identityToken, applicationIdentifier: details.appIdentifier).get()
        return try await sendTokenValidationRequest(details: details)
    }
}

// MARK: - Internal Methods

private extension Request.SignInWithApple {

    func sendTokenGenerationRequest(details: AppleTokenGenerationDetails) async throws -> AppleTokenResponse {
        let authToken = AppleAuthToken(clientId: details.appIdentifier, teamId: details.teamIdentifier)

        let signer = JWTSigner.es256(key: details.privateKey.key)
        let clientSecret = try signer.sign(authToken, kid: details.privateKey.kid)

        let body = AppleTokenRequest(
            clientId: details.appIdentifier,
            clientSecret: clientSecret,
            code: details.authorizationCode,
            redirectUri: details.redirectURI
        )

        let response = try await request.client.postTokenRequest(body: body)

        return try response.parseAppleTokenResponse()
    }

    func sendTokenValidationRequest(details: AppleTokenValidationDetails) async throws -> AppleTokenResponse {
        let authToken = AppleAuthToken(clientId: details.appIdentifier, teamId: details.teamIdentifier)

        let signer = JWTSigner.es256(key: details.privateKey.key)
        let clientSecret = try signer.sign(authToken, kid: details.privateKey.kid)

        let body = AppleTokenRequest(
            clientId: details.appIdentifier,
            clientSecret: clientSecret,
            refreshToken: details.refreshToken
        )

        let response = try await request.client.postTokenRequest(body: body)

        return try response.parseAppleTokenResponse()
    }
}

private extension ClientResponse {

    func parseAppleTokenResponse() throws -> AppleTokenResponse {
        if let error = parseAppleErrorResponse() {
            throw error
        }

        return try content.decode(AppleTokenResponse.self, using: JSONDecoder.apple)
    }

    private func parseAppleErrorResponse() -> Error? {
        do {
            let error = try content.decode(AppleErrorResponse.self, using: JSONDecoder.apple)
            return NSError(domain: "Vapor - Sign in with Apple",
                           code: 0,
                           userInfo: [NSLocalizedDescriptionKey : error.error])
        } catch { }

        return nil
    }
}
