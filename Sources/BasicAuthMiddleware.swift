//
//  BasicAuthMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/28/16.
//
//

import Turnstile
import Vapor
import HTTP

class BasicAuthMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        if let credentials = request.auth?.basic {
            _ = try? request.user.login(credentials: credentials)
        }
        
        return try next.respond(to: request)
    }
}
