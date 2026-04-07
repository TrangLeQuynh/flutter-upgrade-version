// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_upgrade_version",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "flutter-upgrade-version", targets: ["flutter_upgrade_version"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "flutter_upgrade_version",
            dependencies: [],
            path: "Sources/flutter_upgrade_version"
        ),
    ]
)
