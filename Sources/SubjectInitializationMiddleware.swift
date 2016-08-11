//
//  UserInitializationMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/28/16.
//
//

import Turnstile
import Vapor
import HTTP

class UserInitializationMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Initialize user
        request.storage["TurnstileUser"] = User(turnstile: turnstile)
        
        return try next.respond(to: request)
    }
}
