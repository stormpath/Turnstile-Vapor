//
//  SessionMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/27/16.
//
//

import Turnstile
import Vapor

class SessionMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Initialize subject
        
        if let sessionIdentifier = request.cookies["TurnstileSession"],
            subject = turnstile.sessionManager.getSubject(identifier: sessionIdentifier) {
            
            request.storage["TurnstileSubject"] = subject
        }
        
        let response = try next.respond(to: request)
        
        if let subject = request.storage["TurnstileSubject"] as? Subject,
            sessionID = subject.authDetails?.sessionID {
            if request.cookies["TurnstileSession"] != sessionID {
                response.cookies["TurnstileSession"] = sessionID
            }
        }
        
        return response
    }
}
