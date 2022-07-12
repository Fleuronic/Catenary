// swift-tools-version:5.1
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Catenary",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "Catenary",
			targets: ["Catenary"]
		),
		.library(
			name: "CatenarySQL",
			targets: ["CatenarySQL"]
		),
		.library(
			name: "CatenaryPostgreSQL",
			targets: ["CatenaryPostgreSQL"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/vapor/postgres-kit", .upToNextMajor(from: "2.5.0")),
		.package(url: "https://github.com/Fleuronic/PersistDB", .branch("master")),
		.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0"),
		.package(url: "https://github.com/Fleuronic/AsyncExtensions", .upToNextMajor(from: "0.4.0")),
		.package(url: "https://github.com/simba909/ReactiveCombineBridge", .branch("master"))
	],
	targets: [
		.target(
			name: "Catenary",
			dependencies: []
		),
		.target(
			name: "CatenaryPostgreSQL",
			dependencies: [
				"Catenary",
				"Identity",
				.product(
					name: "PostgresKit",
					package: "postgres-kit"
				)
			]
		),
		.target(
			name: "CatenarySQL",
			dependencies: [
				"Catenary",
				"PersistDB",
				"Identity",
				"AsyncExtensions",
				"ReactiveCombineBridge"
			]
		),
		.testTarget(
			name: "CatenaryTests",
			dependencies: ["Catenary"]
		)
	]
)
