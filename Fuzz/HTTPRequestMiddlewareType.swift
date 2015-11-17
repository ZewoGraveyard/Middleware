// HTTPRequestMiddlewareType.swift
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

public protocol HTTPRequestMiddlewareType {
    func respond(request: HTTPRequest) -> HTTPRequestMiddlewareResult
}

public func >>>(middlewareA: HTTPRequestMiddlewareType, middlewareB: HTTPRequestMiddlewareType) -> HTTPRequestMiddlewareType {
    return SimpleHTTPRequestMiddleware { request in
        switch middlewareA.respond(request) {
        case .Next(let request):
            return middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: HTTPRequest -> HTTPRequestMiddlewareResult, middlewareB: HTTPRequestMiddlewareType) -> HTTPRequestMiddlewareType {
    return SimpleHTTPRequestMiddleware { request in
        switch middlewareARespond(request) {
        case .Next(let request):
            return middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareA: HTTPRequestMiddlewareType, middlewareBRespond: HTTPRequest -> HTTPRequestMiddlewareResult) -> HTTPRequestMiddlewareType {
    return SimpleHTTPRequestMiddleware { request in
        switch middlewareA.respond(request) {
        case .Next(let request):
            return middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: HTTPRequest -> HTTPRequestMiddlewareResult, middlewareBRespond: HTTPRequest -> HTTPRequestMiddlewareResult) -> HTTPRequestMiddlewareType {
    return SimpleHTTPRequestMiddleware { request in
        switch middlewareARespond(request) {
        case .Next(let request):
            return middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}


public func >>>(middlewareA: HTTPRequestMiddlewareType, middlewareB: HTTPFallibleRequestMiddlewareType) -> HTTPFallibleRequestMiddlewareType {
    return SimpleHTTPFallibleRequestMiddleware { request in
        switch middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: HTTPRequest -> HTTPRequestMiddlewareResult, middlewareB: HTTPFallibleRequestMiddlewareType) -> HTTPFallibleRequestMiddlewareType {
    return SimpleHTTPFallibleRequestMiddleware { request in
        switch middlewareARespond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareA: HTTPRequestMiddlewareType, middlewareBRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult) -> HTTPFallibleRequestMiddlewareType {
    return SimpleHTTPFallibleRequestMiddleware { request in
        switch middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: HTTPRequest -> HTTPRequestMiddlewareResult, middlewareBRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult) -> HTTPFallibleRequestMiddlewareType {
    return SimpleHTTPFallibleRequestMiddleware { request in
        switch middlewareARespond(request) {
        case .Next(let request):
            return try middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, responder: HTTPFallibleResponderType) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        switch middleware.respond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest -> HTTPRequestMiddlewareResult, responder: HTTPFallibleResponderType) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        switch middlewareRespond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, respond: HTTPRequest throws -> HTTPResponse) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        switch middleware.respond(request) {
        case .Next(let request):
            return try respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest -> HTTPRequestMiddlewareResult, respond: HTTPRequest throws -> HTTPResponse) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        switch middlewareRespond(request) {
        case .Next(let request):
            return try respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, responder: HTTPResponderType) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        switch middleware.respond(request) {
        case .Next(let request):
            return responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest -> HTTPRequestMiddlewareResult, responder: HTTPResponderType) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        switch middlewareRespond(request) {
        case .Next(let request):
            return responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, respond: HTTPRequest -> HTTPResponse) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        switch middleware.respond(request) {
        case .Next(let request):
            return respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest -> HTTPRequestMiddlewareResult, respond: HTTPRequest -> HTTPResponse) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        switch middlewareRespond(request) {
        case .Next(let request):
            return respond(request)
        case .Respond(let response):
            return response
        }
    }
}
