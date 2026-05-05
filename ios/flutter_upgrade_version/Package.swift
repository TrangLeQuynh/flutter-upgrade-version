// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "flutter_upgrade_version",
  platforms: [
    .iOS("13.0")
  ],
  products: [
    // If the plugin name contains "_", replace with "-" for the library name.
    .library(name: "flutter-upgrade-version", targets: ["flutter_upgrade_version"])
  ],
  dependencies: [
    .package(name: "FlutterFramework", path: "../FlutterFramework")
  ],
  targets: [
    .target(
      // Update your target name.
      name: "flutter_upgrade_version",
      dependencies: [
          .product(name: "FlutterFramework", package: "FlutterFramework")
      ],
      path: "Sources/flutter_upgrade_version",
      resources: []
    )
  ]
)
