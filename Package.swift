import PackageDescription

let package = Package(
	name: "Middleware",
	dependencies: [
        .Package(url: "https://github.com/Zewo/Router", majorVersion: 0, minor: 1)
	]
)
