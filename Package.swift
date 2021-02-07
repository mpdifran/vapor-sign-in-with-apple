// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SignInWithApple",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SignInWithApple",
            targets: ["SignInWithApple"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.3.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "SignInWithApple",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt"),
            ]),
        .testTarget(
            name: "SignInWithAppleTests",
            dependencies: ["SignInWithApple"]),
    ]
)
