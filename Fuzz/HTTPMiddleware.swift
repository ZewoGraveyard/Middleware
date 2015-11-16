// HTTPMiddleware.swift
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

infix operator >>> { associativity left }

public func >>><MiddlewareA : HTTPRequestMiddlewareType, MiddlewareB : HTTPRequestMiddlewareType>(middlewareA: MiddlewareA, middlewareB: MiddlewareB) -> HTTPRequestMiddlewareType {
    return SimpleHTTPRequestMiddleware { request in
        switch middlewareA.respond(request) {
        case .Next(let request):
            return middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>><MiddlewareA : HTTPRequestMiddlewareType, MiddlewareB : HTTPFallibleRequestMiddlewareType>(middlewareA: MiddlewareA, middlewareB: MiddlewareB) -> HTTPFallibleRequestMiddlewareType {
    return SimpleHTTPFallibleRequestMiddleware { request in
        switch middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>><Middleware : HTTPRequestMiddlewareType, Responder : HTTPResponderType>(middleware: Middleware, responder: Responder) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        switch middleware.respond(request) {
        case .Next(let request):
            return responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>><MiddlewareA : HTTPFallibleRequestMiddlewareType, MiddlewareB : HTTPFallibleRequestMiddlewareType>(middlewareA: MiddlewareA, middlewareB: MiddlewareB) -> HTTPFallibleRequestMiddlewareType {
    return SimpleHTTPFallibleRequestMiddleware { request in
        switch try middlewareA.respond(request) {
        case .Next(let request):
            return try middlewareB.respond(request)
        case .Respond(let response):
            return .Respond(response)
        }
    }
}

public func >>><Middleware : HTTPFallibleRequestMiddlewareType, Responder : HTTPFallibleResponderType>(middleware: Middleware, responder: Responder) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return try responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>><Middleware : HTTPFallibleRequestMiddlewareType, Responder : HTTPResponderType>(middleware: Middleware, responder: Responder) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        switch try middleware.respond(request) {
        case .Next(let request):
            return responder.respond(request)
        case .Respond(let response):
            return response
        }
    }
}

public func >>><Responder : HTTPResponderType, Middleware : HTTPRequestResponseMiddlewareType>(responder: Responder, middleware: Middleware) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        let response = responder.respond(request)
        middleware.respond(request, response: response)
        return response
    }
}

public func >>><Responder : HTTPFallibleResponderType, Middleware : HTTPRequestResponseMiddlewareType>(responder: Responder, middleware: Middleware) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        let response = try responder.respond(request)
        middleware.respond(request, response: response)
        return response
    }
}

public func >>><Responder : HTTPResponderType, Middleware : HTTPResponseMiddlewareType>(responder: Responder, middleware: Middleware) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        return middleware.respond(responder.respond(request))
    }
}

public func >>><Responder : HTTPFallibleResponderType, Middleware : HTTPFallibleResponseMiddlewareType>(responder: Responder, middleware: Middleware) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        return try middleware.respond(responder.respond(request))
    }
}

public func >>><Responder : HTTPFallibleResponderType, Middleware : HTTPResponseMiddlewareType>(responder: Responder, middleware: Middleware) -> HTTPFallibleResponderType {
    return SimpleHTTPFallibleResponder { request in
        return middleware.respond(try responder.respond(request))
    }
}

public func >>><Responder : HTTPFallibleResponderType, FailureResponder : HTTPFailureResponderType>(responder: Responder, failureResponder: FailureResponder) -> HTTPResponderType {
    return SimpleHTTPResponder { request in
        do {
            return try responder.respond(request)
        } catch {
            return failureResponder.respond(error)
        }
    }
}

func >>><Responder : HTTPResponderType, Middleware : HTTPResponderMiddlewareType>(responder: Responder, middleware: Middleware) -> HTTPResponderType {
    return SimpleHTTPResponder(respond: middleware.respond(responder.respond))
}