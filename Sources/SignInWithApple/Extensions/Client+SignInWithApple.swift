//
//  Client+SignInWithApple.swift
//  
//
//  Created by Mark DiFranco on 2021-02-07.
//

import Foundation
import Vapor

extension Client {

    func postTokenRequest(body: AppleTokenRequest) throws -> EventLoopFuture<ClientResponse> {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")

        return post("https://appleid.apple.com/auth/token", headers: headers) { (request) in
            request.body = .init(string: try URLEncodedFormEncoder().encode(body))
        }
    }
}
