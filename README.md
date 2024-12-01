# Vapor - Sign in with Apple

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmpdifran%2Fvapor-sign-in-with-apple%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/mpdifran/vapor-sign-in-with-apple)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmpdifran%2Fvapor-sign-in-with-apple%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/mpdifran/vapor-sign-in-with-apple)

Utilities to simplify Sign in with Apple for Vapor projects.

## Token Generation
Use the following method to generate refresh and access tokens from Apple's servers. Apple's documentation on this process can be found [here](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
```
let details = AppleTokenGenerationDetails(...)
let tokenResponse = try await request.signInWithApple.generateAppleTokens(details: details)    
// Store tokens
```

## Token Validation
Use the following method to validate an existing refresh token obtained by the above method. Apple's documentation on this process can be found [here](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
```
let details = AppleTokenValidationDetails(...)
let tokenResponse = try await request.signInWithApple.validateAppleTokens(details: details)
// Store tokens
```
