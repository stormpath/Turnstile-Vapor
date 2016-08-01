//
//  SubjectInitializationMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/28/16.
//
//

import Turnstile
import Vapor

class SubjectInitializationMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Initialize subject
        request.storage["TurnstileSubject"] = turnstile.createSubject()
        
        return try next.respond(to: request)
    }
}
