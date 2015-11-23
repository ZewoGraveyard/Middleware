Fuzz
====

[![Swift 2.1](https://img.shields.io/badge/Swift-2.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms OS X | iOS](https://img.shields.io/badge/Platforms-OS%20X%20%7C%20iOS-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![Cocoapods Compatible](https://img.shields.io/badge/Cocoapods-Compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/Fuzz)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-Compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Travis](https://img.shields.io/badge/Build-Passing-4BC51D.svg?style=flat)](https://travis-ci.org/Zewo/Fuzz)
[![codecov.io](http://codecov.io/github/Zewo/Fuzz/coverage.svg?branch=master)](http://codecov.io/github/Zewo/Fuzz?branch=master)

**Fuzz** is an HTTP middleware framework for **Swift 2**.

## Features

- [x] No `Foundation` dependency (**Linux ready**)
- [x] HTTP Request Middleware
- [x] HTTP Response Middleware

## Usage

```swift
struct Middleware : HTTPRequestMiddlewareType {
    func respond(request: HTTPRequest) -> HTTPRequestMiddlewareResult {
        // You can change the request and pass it forward
        return .Next(request)
        
        // Or you can respond early and bypass the chain
        return .Respond(HTTPResponse(statusCode: 404, reasonPhrase: "Not Found"))
    }
}

struct Responder : HTTPResponderType {
    func respond(request: HTTPRequest) -> HTTPResponse {
        // May or may not be called
        return HTTPResponse(statusCode: 200, reasonPhrase: "OK")
    }
}

let request = HTTPRequest(method: .GET, uri: URI(path: "/"))
let chain = Middleware() >>> Responder()
let response = chain.respond(request)
```

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build Fuzz.

To integrate **Fuzz** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'Fuzz', '0.1'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate **Fuzz** into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Zewo/Fuzz" == 0.1
```

### Command Line Application

To use **Fuzz** in a command line application:

- Install the [Swift Command Line Application](https://github.com/Zewo/Swift-Command-Line-Application-Template) Xcode template
- Follow [Cocoa Pods](#cocoapods) or [Carthage](#carthage) instructions.

License
-------

**Fuzz** is released under the MIT license. See LICENSE for details.
