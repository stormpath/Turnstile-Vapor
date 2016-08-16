import PackageDescription

let package = Package(
    name: "VaporTurnstile",
    dependencies: [
        .Package(url: "https://github.com/stormpath/Turnstile.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 16)
    ]
)
