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

class SubjectInitializationMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Initialize user
        request.user = Subject(turnstile: turnstile)
        
        return try next.respond(to: request)
    }
}
