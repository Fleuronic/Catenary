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
		.package(url: "https://github.com/almazrafi/DictionaryCoder.git", from: "1.2.0"),
		.package(url: "https://github.com/NicholasBellucci/SociableWeaver.git", from: "0.1.0")
	],
	targets: [
		.target(
			name: "Catenary",
			dependencies: [
				"Catena",
				"DictionaryCoder",
				"SociableWeaver"
			]
		)
	]
)
