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
        var subject: Subject!
        var newSessionID: String?
        
        if let sessionIdentifier = request.cookies["TurnstileSession"] {
            subject = turnstile.sessionManager.getSubject(identifier: sessionIdentifier)
        }
        
        if subject == nil {
            subject = Subject(turnstile: turnstile)
            newSessionID = turnstile.sessionManager.createSession(subject: subject)
        }
        
        request.storage["TurnstileSubject"] = subject
        
        let response = try next.respond(to: request)
        
        if let newSessionID = newSessionID {
            response.cookies["TurnstileSession"] = newSessionID
        }
        
        return response
    }
}
