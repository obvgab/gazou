// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "gazou",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/johnsundell/plot", from: "0.14.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird", from: "2.0.0-beta.1"),
        .package(url: "https://github.com/apple/swift-openapi-runtime.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/swift-openapi-hummingbird", branch: "2.x.x")
    ],
    targets: [
        .executableTarget(
            name: "Gazou",
            dependencies: [
                .product(name: "Plot", package: "plot"),
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIHummingbird", package: "swift-openapi-hummingbird")
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ])
    ]
)
