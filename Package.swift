// swift-tools-version:5.7
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Catenary",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(
			name: "Catenary",
			targets: ["Catenary"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Catena", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Schemata", branch: "master"),
		.package(url: "https://github.com/Fleuronic/PersistDB", branch: "master")
	],
	targets: [
		.target(
			name: "Catenary",
			dependencies: [
				"Catena",
				"Schemata",
				"PersistDB"
			]
		)
	]
)
