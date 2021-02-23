# Vapor - Sign in with Apple

Utilities to simplify Sign in with Apple for Vapor projects.

## Token Generation
Use the following method to generate refresh and access tokens from Apple's servers. Apple's documentation on this process can be found [here](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
```
let details = AppleTokenGenerationDetails(...)
request.generateAppleTokens(details: details)
    .flatMap { (tokenResponse) in
        // Store tokens
    }
}
```

## Token Validation
Use the following method to validate an existing refresh token obtained by the above method. Apple's documentation on this process can be found [here](https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens).
```
let details = AppleTokenValidationDetails(...)
request.validateAppleTokens(details: details)
    .flatMap { (tokenResponse) in
        // Store tokens
    }
}
```
