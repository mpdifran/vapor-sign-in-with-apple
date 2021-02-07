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
        // Must set the user agent here, otherwise a 400 level error will be returned.
        headers.add(name: "User-Agent",
                    value: "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6'")
        headers.add(name: "Accept", value: "application/json")
        headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")

        return post("https://appleid.apple.com/auth/token", headers: headers) { (request) in
            request.body = .init(string: try URLEncodedFormEncoder().encode(body))
        }
    }
}
