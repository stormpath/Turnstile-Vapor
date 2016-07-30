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
        
        // If we have a new session, set a new cookie
        if let sessionID = request.subject.authDetails?.sessionID
            where request.cookies["TurnstileSession"] != request.subject.authDetails?.sessionID {
            // Workaround for Vapor issue https://github.com/qutheory/vapor/issues/495
            response.headers["Set-Cookie"] = "TurnstileSession=\(sessionID); path=/;"
        }
        else if request.cookies["TurnstileSession"] != nil && request.subject.authDetails?.sessionID == nil {
            // If we have a cookie but no session, delete it. 
            response.headers["Set-Cookie"] = "TurnstileSession=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT"
        }
        
        return response
    }
}
