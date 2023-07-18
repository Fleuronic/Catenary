// swift-tools-version:5.7
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Catenary",
	platforms: [
		.iOS(.v12),
		.macOS(.v10_13),
		.watchOS(.v6),
		.tvOS(.v12)
	],
	products: [
		.library(
			name: "Catenary",
			targets: ["Catenary"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Catena", branch: "main")
	],
	targets: [
		.target(
			name: "Catenary",
			dependencies: [
				"Catena"
			]
		)
	]
)
