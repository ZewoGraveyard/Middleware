// FuzzTests.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest
import Fuzz

class FuzzTests: XCTestCase {
    func testRequestMiddlewareResponderNext() {
        struct Middleware : HTTPRequestMiddlewareType {
            func respond(request: HTTPRequest) -> HTTPRequestMiddlewareResult {
                XCTAssert(request.method == .GET)
                return .Next(request)
            }
        }

        struct Responder : HTTPResponderType {
            func respond(request: HTTPRequest) -> HTTPResponse {
                XCTAssert(request.method == .GET)
                return HTTPResponse(statusCode: 200, reasonPhrase: "OK")
            }
        }

        let request = HTTPRequest(method: .GET, uri: URI(path: "/"))

        let responder = Middleware() >>> Responder()
        let response = responder.respond(request)
        XCTAssert(response.statusCode == 200)
    }

    func testRequestMiddlewareResponderRespond() {
        struct Middleware : HTTPRequestMiddlewareType {
            func respond(request: HTTPRequest) -> HTTPRequestMiddlewareResult {
                XCTAssert(request.method == .GET)
                return .Respond(HTTPResponse(statusCode: 200, reasonPhrase: "OK"))
            }
        }

        struct Responder : HTTPResponderType {
            func respond(request: HTTPRequest) -> HTTPResponse {
                XCTAssert(false)
                return HTTPResponse(statusCode: 404, reasonPhrase: "Not Found")
            }
        }

        let request = HTTPRequest(method: .GET, uri: URI(path: "/"))

        let responder = Middleware() >>> Responder()
        let response = responder.respond(request)
        XCTAssert(response.statusCode == 200)
    }
}
