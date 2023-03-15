// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SurveyMakito",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SurveyMakito",
            targets: ["SurveyMakito"]),
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "9.3.0"),
        .package(name: "BetterCodable", url:"https://github.com/marksands/BetterCodable", from: "0.4.0"),
        .package(url: "git@github.com:ksteigerwald/FirebaseService.git", .revision("5472e7f559051633e784409cd8b035893c9cca05")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SurveyMakito",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "Firebase"),
                .product(name: "FirebaseFirestoreSwift", package: "Firebase"),
                .product(name: "FirebaseService", package: "FirebaseService"),
                "BetterCodable",
            ]),
        .testTarget(
            name: "SurveyMakitoTests",
            dependencies: ["SurveyMakito"]),
    ]
)
