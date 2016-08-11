//
//  SessionMiddleware.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/27/16.
//
//

import Turnstile
import Vapor
import HTTP

class SessionMiddleware: Middleware {
    let turnstile: Turnstile
    
    init(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Initialize user
        
        if let sessionIdentifier = request.cookies["TurnstileSession"],
            let user = try? turnstile.sessionManager.getUser(identifier: sessionIdentifier) {
            
            request.storage["TurnstileUser"] = user
        }
        
        let response = try next.respond(to: request)
        
        // If we have a new session, set a new cookie
        if let sessionID = request.user.authDetails?.sessionID
            , request.cookies["TurnstileSession"] != request.user.authDetails?.sessionID {
            // Workaround for Vapor issue https://github.com/qutheory/vapor/issues/495
            response.headers["Set-Cookie"] = "TurnstileSession=\(sessionID); path=/;"
        }
        else if request.cookies["TurnstileSession"] != nil && request.user.authDetails?.sessionID == nil {
            // If we have a cookie but no session, delete it. 
            response.headers["Set-Cookie"] = "TurnstileSession=deleted; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT"
        }
        
        return response
    }
}
