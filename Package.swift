import PackageDescription

let package = Package(
    name: "VaporTurnstile",
    dependencies: [
        .Package(url: "../Turnstile", majorVersion: 0),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 16)
    ]
)
