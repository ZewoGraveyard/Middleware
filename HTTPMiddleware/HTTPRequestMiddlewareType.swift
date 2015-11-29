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

import HTTP

public protocol HTTPRequestMiddlewareType {
    func respond(request: HTTPRequest) throws -> HTTPRequestMiddlewareResult
}

public func >>>(middlewareA: HTTPRequestMiddlewareType, middlewareB: HTTPRequestMiddlewareType) -> HTTPRequestMiddlewareType {
    return HTTPRequestMiddleware { request in
        switch try middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, middlewareB: HTTPRequestMiddlewareType) -> HTTPRequestMiddlewareType {
    return HTTPRequestMiddleware { request in
        switch try middlewareARespond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareA: HTTPRequestMiddlewareType, middlewareBRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult) -> HTTPRequestMiddlewareType {
    return HTTPRequestMiddleware { request in
        switch try middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, middlewareBRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult) -> HTTPRequestMiddlewareType {
    return HTTPRequestMiddleware { request in
        switch try middlewareARespond(request) {
        case .Next(let request):
            return try middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, responder: HTTPResponderType) -> HTTPResponderType {
    return HTTPResponder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, responder: HTTPResponderType) -> HTTPResponderType {
    return HTTPResponder { request in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, respond: HTTPRequest throws -> HTTPResponse) -> HTTPResponderType {
    return HTTPResponder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, respond: HTTPRequest throws -> HTTPResponse) -> HTTPResponderType {
    return HTTPResponder { request in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return try respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, respond: HTTPRequest -> HTTPResponse) -> HTTPResponderType {
    return HTTPResponder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, respond: HTTPRequest -> HTTPResponse) -> HTTPResponderType {
    return HTTPResponder { request in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return respond(request)
        case .Respond(let response):
            return response
        }
    }
}


















public func >>>(middleware: HTTPRequestMiddlewareType, responder: HTTPIdentifiableResponderType) -> HTTPIdentifiableResponderType {
    return HTTPIdentifiableResponder { request, id in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try responder.respond(request, id: id)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, responder: HTTPIdentifiableResponderType) -> HTTPIdentifiableResponderType {
    return HTTPIdentifiableResponder { request, id in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return try responder.respond(request, id: id)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, respond: (HTTPRequest, String) throws -> HTTPResponse) -> HTTPIdentifiableResponderType {
    return HTTPIdentifiableResponder { request, id in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try respond(request, id)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, respond: (HTTPRequest, String) throws -> HTTPResponse) -> HTTPIdentifiableResponderType {
    return HTTPIdentifiableResponder { request, id in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return try respond(request, id)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: HTTPRequestMiddlewareType, respond: (HTTPRequest, String) -> HTTPResponse) -> HTTPIdentifiableResponderType {
    return HTTPIdentifiableResponder { request, id in
        switch try middleware.respond(request) {
        case .Next(let request):
            return respond(request, id)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: HTTPRequest throws -> HTTPRequestMiddlewareResult, respond: (HTTPRequest, String) -> HTTPResponse) -> HTTPIdentifiableResponderType {
    return HTTPIdentifiableResponder { request, id in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return respond(request, id)
        case .Respond(let response):
            return response
        }
    }
}