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
- [x] Request Middleware
- [x] Response Middleware

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

To integrate Fuzz into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'Fuzz'
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
github "Zewo/Fuzz"
```

### Manually

If you prefer not to use a dependency manager, you can integrate **Fuzz** into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add **Fuzz** as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/Zewo/Fuzz.git
```

- Open the new `Fuzz` folder, and drag the `Fuzz.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Fuzz.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `Fuzz.xcodeproj` folders each with two different versions of the `Fuzz.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `Fuzz.framework`.

- Select the top `Fuzz.framework` for OS X and the bottom one for iOS.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Fuzz` will be listed as either `Fuzz iOS` or `Fuzz OSX`.

- And that's it!

> The `Fuzz.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

License
-------

**Fuzz** is released under the MIT license. See LICENSE for details.
