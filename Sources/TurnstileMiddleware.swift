//
//  TurnstileMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/27/16.
//
//

import Turnstile
import Vapor

class TurnstileMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Initialize subject
        let sessionIdentifier = request.cookies["TurnstileSession"] ?? turnstile.sessionManager.createSession(subject: Subject(turnstile: turnstile))
        let subject = turnstile.sessionManager.getSubject(identifier: sessionIdentifier)
        
        assert(subject != nil, "we should have created a subject")
        
        request.storage["TurnstileSubject"] = subject
        
        let response = try next.respond(to: request)
        response.cookies["TurnstileSession"] = sessionIdentifier
        
        return response
    }
}
