import PackageDescription

let package = Package(
	name: "Middleware",
	dependencies: [
        .Package(url: "https://github.com/Zewo/Router", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/Zewo/CURIParser.git", majorVersion: 0, minor: 1),
    ]
)