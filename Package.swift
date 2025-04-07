// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// use local package path
let packageLocal: Bool = false

let oscaEssentialsVersion = Version("1.1.0")
let oscaNetworkServiceVersion = Version("1.1.0")

let package = Package(
  name: "OSCATestCaseExtension",
  defaultLocalization: "de",
  platforms: [.iOS(.v13)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(name: "OSCATestCaseExtension",
             targets: ["OSCATestCaseExtension"]),
    .library(name: "OSCATestCaseExtensionStatic",
             type: .static,
             targets: ["OSCATestCaseExtension"]),
    .library(name: "OSCATestCaseExtensionDynamic",
             type: .dynamic,
             targets: ["OSCATestCaseExtension"]),
  ],// end products
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    // OSCAEssentials
    packageLocal ? .package(path: "../OSCAEssentials") :
    .package(url: "https://git-dev.solingen.de/smartcityapp/modules/oscaessentials-ios.git",
             .upToNextMinor(from: oscaEssentialsVersion)),
    // OSCANetworkService
    packageLocal ? .package(path: "../OSCANetworkService") :
    .package(url: "https://git-dev.solingen.de/smartcityapp/modules/oscanetworkservice-ios.git",
             .upToNextMinor(from: oscaNetworkServiceVersion))
  ],// end dependencies
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "OSCATestCaseExtension",
      dependencies: [/* OSCAEssentials */
                     .product(name: "OSCAEssentials",
                              package: packageLocal ? "OSCAEssentials" : "oscaessentials-ios"),
                     .product( name: "OSCANetworkService",
                               package: packageLocal ? "OSCANetworkService" : "oscanetworkservice-ios")],
      path: "OSCATestCaseExtension/OSCATestCaseExtension",
      exclude:["Info.plist"],// end exclude
      resources: [.process("Resources")
      ]// end resources
    ),// end target
    .testTarget(
      name: "OSCATestCaseExtensionTests",
      dependencies: ["OSCATestCaseExtension"],
      path: "OSCATestCaseExtension/OSCATestCaseExtensionTests",
      exclude:["Info.plist"],
      resources: []
    ),// end testTarget
  ]// end targets
)// end Package
