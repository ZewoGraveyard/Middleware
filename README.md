HTTPMiddleware
==============

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms Linux](https://img.shields.io/badge/Platforms-Linux-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://tldrlegal.com/license/mit-license)
[![Slack Status](https://zewo-slackin.herokuapp.com/badge.svg)](https://zewo-slackin.herokuapp.com)

**HTTPMiddleware** is an HTTP middleware framework for **Swift 2.2**.

## Features

- [x] HTTP Request Middleware
- [x] HTTP Response Middleware

## Usage

```swift
import HTTP
import HTTPMiddleware

struct Middleware: HTTPRequestMiddlewareType {
    func respond(request: HTTPRequest) -> HTTPRequestMiddlewareResult {
        // You can change the request and pass it forward
        return .Next(request)
        
        // Or you can respond early and bypass the chain
        return .Respond(HTTPResponse(statusCode: 404, reasonPhrase: "Not Found"))
    }
}

struct Responder: HTTPResponderType {
    func respond(request: HTTPRequest) -> HTTPResponse {
        // May or may not be called depending on the middleware
        return HTTPResponse(statusCode: 200, reasonPhrase: "OK")
    }
}

let request = HTTPRequest(method: .GET, uri: URI(path: "/"))
let chain = Middleware() >>> Responder()
let response = chain.respond(request)
```

## Installation

- Install [`uri_parser`](https://github.com/Zewo/uri_parser)

```bash
$ git clone https://github.com/Zewo/uri_parser.git
$ cd uri_parser
$ make
$ dpkg -i uri_parser.deb
```

- Add `HTTPMiddleware` to your `Package.swift`

```swift
import PackageDescription

let package = Package(
	dependencies: [
		.Package(url: "https://github.com/Zewo/HTTPMiddleware.git", majorVersion: 0, minor: 1)
	]
)
```

## Community

[![Slack](http://s13.postimg.org/ybwy92ktf/Slack.png)](https://zewo-slackin.herokuapp.com)

Join us on [Slack](https://zewo-slackin.herokuapp.com).

License
-------

**HTTPMiddleware** is released under the MIT license. See LICENSE for details.
