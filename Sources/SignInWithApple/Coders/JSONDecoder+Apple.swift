//
//  JSONDecoder+Apple.swift
//  SignInWithApple
//
//  Created by Mark DiFranco on 2025-01-06.
//

import Foundation

extension JSONDecoder {
    static let apple: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
