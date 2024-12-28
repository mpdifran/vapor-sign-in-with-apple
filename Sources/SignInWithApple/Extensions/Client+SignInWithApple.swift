//
//  Client+SignInWithApple.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor

extension Client {

    func postTokenRequest(body: AppleTokenRequest) async throws -> ClientResponse {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")

        return try await post("https://appleid.apple.com/auth/token", headers: headers) { (request) in
            request.body = .init(string: try URLEncodedFormEncoder().encode(body))
        }
    }

    func postTokenInvalidation(body: AppleTokenInvalidationRequest) async throws -> ClientResponse {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")

        return try await post("https://appleid.apple.com/auth/revoke", headers: headers) { (request) in
            request.body = .init(string: try URLEncodedFormEncoder().encode(body))
        }
    }
}
