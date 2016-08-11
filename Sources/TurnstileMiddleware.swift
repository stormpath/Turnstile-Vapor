//
//  TurnstileMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/29/16.
//
//

import Turnstile
import Vapor
import HTTP

private class SessionRequired: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        return try next.respond(to: request)
    }
}

class APIKeyAuthenticationRequired: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        if request.user.authenticated && request.user.authDetails?.credentialType is APIKey.Type {
            return try next.respond(to: request)
        } else {
            return try Response(status: .unauthorized, json: JSON(["error": "401 Unauthorized"]))
        }
    }
}
