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
		.package(url: "https://github.com/vapor/postgres-kit", .branch("main")),
		.package(url: "https://github.com/PersistX/PersistDB", .branch("master")),
		.package(url: "https://github.com/Fleuronic/AsyncExtensions", .upToNextMajor(from: "0.2.1")),
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
