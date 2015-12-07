// RequestMiddlewareType.swift
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

public protocol RequestMiddlewareType {
    func respond(request: Request) throws -> RequestMiddlewareResult
}

public func >>>(middlewareA: RequestMiddlewareType, middlewareB: RequestMiddlewareType) -> RequestMiddlewareType {
    return RequestMiddleware { request in
        switch try middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: Request throws -> RequestMiddlewareResult, middlewareB: RequestMiddlewareType) -> RequestMiddlewareType {
    return RequestMiddleware { request in
        switch try middlewareARespond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareA: RequestMiddlewareType, middlewareBRespond: Request throws -> RequestMiddlewareResult) -> RequestMiddlewareType {
    return RequestMiddleware { request in
        switch try middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middlewareARespond: Request throws -> RequestMiddlewareResult, middlewareBRespond: Request throws -> RequestMiddlewareResult) -> RequestMiddlewareType {
    return RequestMiddleware { request in
        switch try middlewareARespond(request) {
        case .Next(let request):
            return try middlewareBRespond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>>(middleware: RequestMiddlewareType, responder: ResponderType) -> ResponderType {
    return Responder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: Request throws -> RequestMiddlewareResult, responder: ResponderType) -> ResponderType {
    return Responder { request in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: RequestMiddlewareType, respond: Request throws -> Response) -> ResponderType {
    return Responder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: Request throws -> RequestMiddlewareResult, respond: Request throws -> Response) -> ResponderType {
    return Responder { request in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return try respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middleware: RequestMiddlewareType, respond: Request -> Response) -> ResponderType {
    return Responder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>>(middlewareRespond: Request throws -> RequestMiddlewareResult, respond: Request -> Response) -> ResponderType {
    return Responder { request in
        switch try middlewareRespond(request) {
        case .Next(let request):
            return respond(request)
        case .Respond(let response):
            return response
        }
    }
}
