//
//  BearerAuthMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/29/16.
//
//

import Turnstile
import Vapor

class BearerAuthMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        if let credentials = request.auth?.bearer {
            _ = try? request.subject.login(credentials: credentials)
        }
        
        return try next.respond(to: request)
    }
}
