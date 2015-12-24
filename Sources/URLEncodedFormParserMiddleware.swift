// URLEncodedFormParserMiddleware.swift
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

import Core
import HTTP

public struct URLEncodedFormParserMiddleware: RequestMiddlewareType {
    private let key = "URLEncodedFormBody"

    public func respond(request: Request) -> RequestMiddlewareResult {
        var request = request

        guard let mediaType = request.contentType where mediaType.type == "application/x-www-form-urlencoded" else {
            return .Next(request)
        }

        guard let bodyString = request.bodyString else {
            return .Next(request)
        }

        request.context[key] = parseURLEncodedString(bodyString)

        return .Next(request)
    }

    private func parseURLEncodedString(string: String) -> [String: String] {
        var parameters: [String: String] = [:]

        for parameter in string.splitBy("&") {
            let tokens = parameter.splitBy("=")

            if tokens.count >= 2 {
                let key = String(URLEncodedString: tokens[0])
                let value = String(URLEncodedString: tokens[1])

                if let key = key, value = value {
                    parameters[key] = value
                }
            }
        }

        return parameters
    }
}

extension Request {
    public var URLEncodedBody: [String: String]? {
        return context["URLEncodedFormBody"] as? [String: String]
    }

    public func getURLEncodedBody() throws -> [String: String] {
        if let URLEncodedBody = URLEncodedBody {
            return URLEncodedBody
        }
        struct Error: ErrorType, CustomStringConvertible {
            let description = "URL encoded form body not found in context. Maybe you forgot to apply the URLEncodedFormParserMiddleware?"
        }
        throw Error()
    }
}

public let parseURLEncodedForm = URLEncodedFormParserMiddleware()